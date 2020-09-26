# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/posts' do
  context 'POST /' do
    context 'with valid input' do
      let(:password_digest) { BCrypt::Password.create('123456789', cost: 1) }
      let(:user) do
        App::Repos::UserRepo.new.create(first_name: 'Test',
                                        last_name: 'Tester',
                                        email: 'test@mail.com',
                                        password_digest: password_digest)
      end
      let(:input) { { title: 'Test', body: 'test', user_id: user.id } }

      it 'succeeds' do
        post_json '/posts', input
        expect(last_response.status).to eq(200)
        user = parsed_body
        expect(user['id']).not_to be_nil
        expect(user['title']).to eq('Test')
        expect(user['body']).to eq('test')
        expect(user['user_id']).to eq(1)
      end
    end

    context 'with invalid input' do
      let(:input) { { title: 'Test', user_id: 32 } }

      it 'returns an error' do
        post_json '/posts', input
        expect(last_response.status).to eq(422)
        user = parsed_body
        expect(user['errors']['body']).to include('is missing')
      end
    end
  end
end
