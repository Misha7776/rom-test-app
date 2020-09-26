# frozen_string_literal: true

module App
  module Services
    class JwtIssuer
      DEFAULT_EXPIRE_TIME = 86_400 # 24 hours

      class << self
        def encode(payload, exp = Time.new + DEFAULT_EXPIRE_TIME)
          payload[:exp] = exp.to_i
          JWT.encode(payload, secret_key)
        end

        def decode(token)
          JWT.decode(token, secret_key).first
        rescue StandardError
          # we don't need to trow errors, just return nil if JWT is invalid or expired
          nil
        end

        def secret_key
          @secret_key ||= fetch_secret_jwt_key
        end

        def fetch_secret_jwt_key
          secret_key = ENV['SECRET_JWT_KEY']
          unless secret_key
            raise ArgumentError,
                  "Missing secret jwt base for #{ENV['HANAMI_ENV']} environment, set this value in .env file"
          end

          secret_key
        end
      end

      private_class_method :secret_key
    end
  end
end
