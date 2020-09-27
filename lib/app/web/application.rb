# frozen_string_literal: true

require 'hanami/middleware/body_parser'

module App
  module Web
    def self.app
      Rack::Builder.new do
        use Hanami::Middleware::BodyParser, :json
        use Warden::Manager do |manager|
          manager.default_strategies :authentication_token
          manager.failure_app = lambda { |_env|
            [
              401,
              {
                'Access-Control-Allow-Origin' => 'http://localhost',
                'Access-Control-Allow-Methods' => %w[GET POST PUT PATCH OPTIONS DELETE].join(','),
                'Access-Control-Allow-Headers' => %w[Content-Type Accept Auth-Token].join(',')
              },
              { errors: 'Authentication failure' }.to_json
            ]
          }
        end
        run App::Web::Router
      end
    end
  end
end
