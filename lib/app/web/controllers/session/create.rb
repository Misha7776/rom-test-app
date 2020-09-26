# frozen_string_literal: true

module App
  module Web
    module Controllers
      module Session
        class Create
          include Hanami::Action
          include RomTestApp::Import['transactions.session.create_session']
          include Dry::Monads[:result]
          include Authentication::Skip

          def call(params)
            case create_session.call(params.to_h)
            in Success(result)
              status 200, result.to_json
            in Failure(result)
              status 401, { errors: result }.to_json
            end
          end
        end
      end
    end
  end
end
