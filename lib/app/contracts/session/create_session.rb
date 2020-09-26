# frozen_string_literal: true

module App
  module Contracts
    module Session
      class CreateSession < Dry::Validation::Contract
        params do
          required(:email).filled(:str?, format?: /@/)
          required(:password).filled(:str?)
        end
      end
    end
  end
end
