# frozen_string_literal: true

module App
  module Web
    Router = Hanami::Router.new do
      post '/users', to: Controllers::Users::Create
      post '/posts', to: Controllers::Posts::Create
      post '/sessions', to: Controllers::Session::Create
    end
  end
end
