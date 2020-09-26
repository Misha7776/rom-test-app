# frozen_string_literal: true

module App
  module Contracts
    module Users
      class CreateUser < Dry::Validation::Contract
        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          optional(:age).filled(:integer)
          required(:email).filled(:string)
          required(:password).filled(:string)
        end
      end
    end
  end
end
