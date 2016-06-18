module TrelloCli
  module CLI
    module Card
      class List

        def initialize
          @options = {}
        end

        def run
          option_parser.parse!

          data = list_cards.map do |c|
            members = (c.member_ids || []).map do |id|
              m = Trello::Member.find(id)
              "#{m.attributes[:full_name]} (#{m.attributes[:username]})"
            end
            {
              name: c.name,
              id: c.id,
              url: c.url,
              desc: c.desc,
              updated: c.last_activity_date,
              members: members,
              comments: c.attributes[:badges]['comments'] || 0,
              attachments: c.attributes[:badges]['attachments'] || 0,
            }
          end

          puts TrelloCli::Formatters::CardList.new(data).output(@options[:output])
        end

        private

        def list_cards
          TrelloCli::Requests::ListCards.new.list @options
        end

        def option_parser
          OptionParser.new do |opts|
            opts.banner = "Usage: trello card [create] [options]"

            opts.on("-b", "--board [BOARD]", "Trello Board Id") do |b|
              @options[:board_id] = b
            end

            opts.on("-l", "--list [LIST]", "List To Query") do |l|
              @options[:list_id] = l
            end

            opts.on("-o", "--output [OUTPUT]", "Output format [json|tsv|legacy]." ) do |o|
              @options[:output] = o
            end
          end
        end

        def help
          puts option_parser.help
        end

      end
    end
  end
end
