# frozen_string_literal: true

module App
  module Contracts
    module Posts
      class CreatePost < Dry::Validation::Contract
        params do
          required(:title).filled(:string)
          required(:body).filled(:string)
          required(:user_id).filled(:integer)
        end
      end
    end
  end
end
