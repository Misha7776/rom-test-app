# frozen_string_literal: true

module App
  module Contracts
    module Users
      class UpdateUser < Dry::Validation::Contract
        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          optional(:age).filled(:integer)
          required(:email).filled(:str?, format?: /@/)
          required(:password_digest).filled(:str?)
        end
      end
    end
  end
end
