module TrelloCli
  module Requests
    class ListComments

      include Shared

      def initialize
        connect_to_trello
      end

      def list(args)
        Trello::Card.find(args[:card_id]).comments
      end

    end
  end
end
