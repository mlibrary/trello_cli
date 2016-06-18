module TrelloCli
  module CLI
    module Comment
      class List

        def initialize
          @options = {}
        end

        def run
          option_parser.parse!

          data = list_comments(@options[:card_id]).map do |c|
            author = Trello::Member.find(c.attributes[:member_creator_id])
            {
              name: "#{author.attributes[:full_name]} (#{author.attributes[:username]})",
              date: c.attributes[:date],
              text: c.attributes[:text],
              id: c.attributes[:action_id]
            }
          end

          puts TrelloCli::Formatters::CommentList.new(data).output @options[:output]
        end

        private

        def list_comments(card_id)
          TrelloCli::Requests::ListComments.new.list(card_id: card_id)
        end

        def option_parser(options=@options)
          OptionParser.new do |opts|
            opts.banner = "Usage: trello comment [list]"

            opts.on("-c", "--card [CARD]", "Include closed board." ) do |o|
              @options[:card_id] = o
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
