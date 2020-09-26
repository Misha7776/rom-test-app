# frozen_string_literal: true

require_relative 'config/application'

RomTestApp::Application.finalize!

include Dry::Monads[:result]

input = {
  first_name: 'Ryan',
  last_name: 'Bigg',
  age: 32
}

create_user = App::Transactions::Users::CreateUser.new
result = create_user.call(input)
case result
when Success
  puts 'User created successfully!'
when Failure(Dry::Validation::Result)
  puts 'User creation failed:'
  puts result.failure.errors.to_h
end
