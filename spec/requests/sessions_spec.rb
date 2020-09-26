# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/sessions' do
  context 'POST /' do
    context 'with valid input' do
      let(:password_digest) { BCrypt::Password.create('123456789', cost: 1) }
      let(:user) do
        App::Repos::UserRepo.new.create(first_name: 'Test',
                                        last_name: 'Tester',
                                        email: 'test@mail.com',
                                        password_digest: password_digest)
      end

      it 'succeeds' do
        post_json '/sessions', { email: user.email, password: '123456789' }
        expect(last_response.status).to eq(200)
        expect(parsed_body['auth_token']).not_to be_nil
      end
    end

    context 'with invalid input' do
      let(:password_digest) { BCrypt::Password.create('123456789', cost: 1) }
      let(:user) do
        App::Repos::UserRepo.new.create(first_name: 'Test',
                                        last_name: 'Tester',
                                        email: 'test@mail.com',
                                        password_digest: password_digest)
      end
      let(:params) { { email: user.email, password: 'fasdasda' } }

      it 'returns an error' do
        post_json '/sessions', params
        expect(last_response.status).to eq(401)
        expect(last_response.body).to eq 'Authentication failure'
      end
    end
  end
end
