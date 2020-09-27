# frozen_string_literal: true

require 'spec_helper'

RSpec.describe App::Contracts::Users::CreateUser do
  context 'requires first_name' do
    let(:input) { { last_name: 'Push', age: 32 } }
    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:first_name]).to include('is missing')
      expect(result.errors[:email]).to include('is missing')
      expect(result.errors[:password_digest]).to include('is missing')

    end
  end

  context 'requires last_name' do
    let(:input) { { first_name: 'Misha', age: 32 } }
    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:last_name]).to include('is missing')
      expect(result.errors[:email]).to include('is missing')
      expect(result.errors[:password_digest]).to include('is missing')
    end
  end

  context 'given valid parameters' do
    let(:input) { { first_name: 'Misha', last_name: 'Push', age: 32, email: 'test@mail.com', password_digest: 'test' } }
    let(:result) { subject.call(input) }

    it 'is valid' do
      expect(result).to be_success
    end
  end
end
