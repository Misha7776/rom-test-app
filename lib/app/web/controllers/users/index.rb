# frozen_string_literal: true

module App
  module Web
    module Controllers
      module Users
        class Index
          include Hanami::Action
          include RomTestApp::Import['repos.user_repo']
          include Authentication

          def call(_)
            status 200, user_repo.all.map(&:to_h).to_json
          end
        end
      end
    end
  end
end
