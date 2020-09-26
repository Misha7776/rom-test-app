# frozen_string_literal: true

require 'spec_helper'

RSpec.describe App::Transactions::Users::CreateUser do
  let(:user_repo) { double('UserRepo') }
  let(:user) { App::User.new(id: 1, first_name: 'Misha') }

  # Here we use the dry-auto_inject dependency injection
  # without hitting the database we can test the transaction
  subject { described_class.new(user_repo: user_repo) }

  context 'with valid input' do
    let(:input) { { first_name: 'Misha', last_name: 'Push', age: 22, email: 'Test@mail.com', password: '12312341' } }


    it 'creates a user' do
      expect(user_repo).to receive(:create) { user }
      result = subject.call(input)
      expect(result).to be_success
      expect(result.success).to eq(user)
    end
  end

  context 'with invalid input' do
    let(:input) { { last_name: 'Push', age: 22 } }

    it 'does not create a user' do
      expect(user_repo).not_to receive(:create)
      result = subject.call(input)
      expect(result).to be_failure
      expect(result.failure.errors[:first_name]).to include('is missing')
    end
  end
end
