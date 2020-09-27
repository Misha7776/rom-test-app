# frozen_string_literal: true

module App
  module Transactions
    module Session
      class CreateSession
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)
        include RomTestApp::Import['contracts.session.create_session']

        def call(params)
          values = yield validate(params)
          session = yield persist(values)

          Success(session)
        end

        def validate(params)
          create_session.call(params).to_monad
        end

        def persist(params)
          if find_user(params) && check_password(@user.password_digest, params['password_digest'])
            Success auth_token: generate_jwt
          else
            Failure password: 'Authentication failure'
          end
        end

        def find_user(params)
          @user = App::Repos::UserRepo.new.find_by(email: params['email'])
        end

        def check_password(password_digest, unencrypted_password)
          App::Services::Password.new(password_digest) == unencrypted_password
        end

        def generate_jwt
          App::Services::JwtIssuer.encode({ user_id: @user.id, iss: 'http://localhost:9292' })
        end
      end
    end
  end
end
