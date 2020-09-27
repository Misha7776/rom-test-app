# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/sessions' do
  context 'POST /' do
    context 'with valid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'succeeds' do
        post_json '/sessions', { email: user.email, password_digest: '123456789' }
        expect(last_response.status).to eq(200)
        expect(parsed_body['auth_token']).not_to be_nil
      end
    end

    context 'with invalid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'returns an error' do
        post_json '/sessions', { email: user.email, password_digest: 'fasdfasdfcasd' }
        expect(last_response.status).to eq(401)
        expect(parsed_body['errors']).to eq 'Authentication failure'
      end
    end
  end
end
