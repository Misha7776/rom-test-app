# frozen_string_literal: true

module App
  module Web
    module Controllers
      module Users
        class Show
          include Hanami::Action
          include RomTestApp::Import['repos.user_repo']
          include Authentication

          def call(params)
            status 200, user_repo.find(params[:id]).to_h.to_json
          end
        end
      end
    end
  end
end
