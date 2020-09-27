# frozen_string_literal: true

require 'spec_helper'
require 'rack/test'

module RequestHelpers
  def app
    App::Web.app
  end

  def post_json(path, data)
    post path, data.to_json, 'CONTENT_TYPE' => 'application/json'
  end

  def get_json(path, data = {})
    get path, data.to_json, { 'CONTENT_TYPE' => 'application/json' }
  end

  def patch_json(path, data = {})
    patch path, data.to_json, { 'CONTENT_TYPE' => 'application/json' }
  end

  def parsed_body
    JSON.parse(last_response.body)
  end

  def jwt_token
    App::Services::JwtIssuer.encode({ user_id: user.id, iss: 'http://localhost:9292' })
  end
end

RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{/spec/requests/}) do |metadata|
    metadata[:request] = true
  end

  config.include Rack::Test::Methods, request: true
  config.include RequestHelpers, request: true
end
