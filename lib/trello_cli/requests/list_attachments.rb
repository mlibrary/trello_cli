module TrelloCli
  module Requests
    class ListAttachments

      include Shared

      def initialize
        connect_to_trello
      end

      def list(args)
        Trello::Card.find(args[:card_id]).attachments
      end

    end
  end
end
