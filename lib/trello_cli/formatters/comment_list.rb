module TrelloCli
  module Formatters
    class CommentList < Base
      def to_legacy
        data.map {|d| "#{d[:name]} #{d[:date]} #{d[:text]} ( #{d[:id]} )"}.join("\n")
      end

      def to_tsv
        data.map {|d| "#{d[:id]}\t#{d[:date]}\t#{d[:name]}\t#{d[:text]}\n"}
      end
    end
  end
end
