# frozen_string_literal: true

module App
  module Web
    module Controllers
      module Users
        class Update
          include Hanami::Action
          include Dry::Monads[:result]
          include RomTestApp::Import['transactions.users.update_user']
          include Authentication

          def call(params)
            case update_user.call(params.to_h)
            in Success(result)
              status 200, result.to_h.to_json
            in Failure(result)
              status 422, { errors: result.errors.to_h }.to_json
            end
          end
        end
      end
    end
  end
end
