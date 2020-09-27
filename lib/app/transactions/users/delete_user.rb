# frozen_string_literal: true

module App
  module Transactions
    module Users
      class DeleteUser
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)
        include RomTestApp::Import['repos.user_repo']

        def call(params)
          user = find_user(params[:id])
          delete(params[:id])

          Success(user)
        end

        def find_user(user_id)
          user_repo.find(user_id)
        end

        def delete(user_id)
          user_repo.users.by_pk(user_id).delete
        end
      end
    end
  end
end
