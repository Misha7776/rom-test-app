# frozen_string_literal: true

module App
  module Web
    Router = Hanami::Router.new do
      # resources 'users', only: %i[create show index update delete]
      post '/users', to: Controllers::Users::Create
      get '/users', to: Controllers::Users::Index
      get '/users/:id', to: Controllers::Users::Show
      patch '/users/:id', to: Controllers::Users::Update
      delete '/users/:id', to: Controllers::Users::Delete

      post '/posts', to: Controllers::Posts::Create
      post '/sessions', to: Controllers::Session::Create
    end
  end
end
