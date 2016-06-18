module TrelloCli
  module CLI
    module Attachment
      class List

        def initialize
          @options = {}
        end

        def run
          option_parser.parse!

          data = list_attachments(@options[:card_id]).map do |a|
            author = Trello::Member.find(a.attributes[:member_id])
            {
              uploader: "#{author.attributes[:full_name]} (#{author.attributes[:username]})",
              filename: a.attributes[:name],
              date: a.attributes[:date],
              url: a.attributes[:url]
            }
          end

          puts TrelloCli::Formatters::AttachmentList.new(data).output @options[:output]
        end

        private

        def list_attachments(card_id)
          TrelloCli::Requests::ListAttachments.new.list(card_id: card_id)
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
