# frozen_string_literal: true

module App
  module Web
    module Controllers
      module Posts
        class Create
          include Hanami::Action
          include RomTestApp::Import['transactions.posts.create_post']
          include Dry::Monads[:result]

          def call(params)
            case create_post.call(params.to_h)
            in Success(result)
              self.body = result.to_h.to_json
              self.status = 200
            in Failure(result)
              self.body = { errors: result.errors.to_h }.to_json
              self.status = 422
            end
          end
        end
      end
    end
  end
end
