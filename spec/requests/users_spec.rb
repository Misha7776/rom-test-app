# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/users' do
  context 'POST /' do
    context 'with valid input' do
      let(:password_digest) { BCrypt::Password.create('123456789', cost: 1) }
      let(:input) do
        { first_name: 'Misha', last_name: 'Push', age: 22, email: 'Test@mail.com',
          password: password_digest }
      end

      it 'succeeds' do
        post_json '/users', input
        expect(last_response.status).to eq(200)
        user = parsed_body
        expect(user['id']).not_to be_nil
        expect(user['first_name']).to eq('Misha')
        expect(user['last_name']).to eq('Push')
        expect(user['age']).to eq(22)
      end
    end

    context 'with invalid input' do
      let(:input) { { last_name: 'Push', age: 22 } }

      it 'returns an error' do
        post_json '/users', input
        expect(last_response.status).to eq(422)
        user = parsed_body
        expect(user['errors']['first_name']).to include('is missing')
      end
    end
  end
end
