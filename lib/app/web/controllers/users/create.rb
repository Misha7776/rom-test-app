# frozen_string_literal: true

module App
  module Web
    module Controllers
      module Users
        class Create
          include Hanami::Action
          include RomTestApp::Import['transactions.users.create_user']
          include Dry::Monads[:result]
          include Authentication::Skip

          def call(params)
            case create_user.call(params.to_h)
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
