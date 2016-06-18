module TrelloCli
  module CLI
    module Commands
      class Comment

        include Shared

        def list
          ensure_credential_envs_set
          TrelloCli::CLI::Comment::List.new.run
        end

      end
    end
  end
end
