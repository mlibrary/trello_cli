module TrelloCli
  module CLI
    module Commands
      class Attachment

        include Shared

        def list
          ensure_credential_envs_set
          TrelloCli::CLI::Attachment::List.new.run
        end

      end
    end
  end
end
