# frozen_string_literal: true

module App
  module Transactions
    module Users
      class UpdateUser
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)
        include RomTestApp::Import['contracts.users.update_user', 'repos.user_repo']

        def call(params)
          values = yield validate(params)
          update(params[:id], values)

          Success(find_user(params[:id]))
        end

        def validate(params)
          update_user.call(params).to_monad
        end

        def find_user(user_id)
          user_repo.find(user_id)
        end

        def update(user_id, result)
          user_repo.users.by_pk(user_id).update(user_params(result))
        end

        def user_params(result)
          App::Services::Password.encrypt(result.values.to_h)
        end
      end
    end
  end
end
