# frozen_string_literal: true

require 'web_helper'

RSpec.describe '/users' do
  context 'POST /users' do
    context 'with valid input' do
      let(:password_digest) { BCrypt::Password.create('123456789', cost: 1) }
      let(:input) do
        { first_name: 'Misha', last_name: 'Push', age: 22, email: 'Test@mail.com',
          password_digest: password_digest }
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

  context 'GET /users' do
    context 'with valid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'succeeds' do
        header('Authorization', "Token #{jwt_token}")
        get_json '/users'
        expect(last_response.status).to eq(200)
        expect(parsed_body.length).to eq 1
      end
    end
  end

  context 'GET /users/:id' do
    context 'with valid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        age: 22,
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'succeeds' do
        header('Authorization', "Token #{jwt_token}")
        get_json "/users/#{user.id}"
        expect(last_response.status).to eq(200)
        user = parsed_body
        expect(user['id']).not_to be_nil
        expect(user['first_name']).to eq('Test')
        expect(user['last_name']).to eq('Tester')
        expect(user['age']).to eq(22)
      end
    end
  end

  context 'DELETE /users/:id' do
    context 'with valid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        age: 22,
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'succeeds' do
        header('Authorization', "Token #{jwt_token}")
        delete "/users/#{user.id}"
        expect(last_response.status).to eq(200)
        user = parsed_body
        expect(user['id']).not_to be_nil
        expect(user['first_name']).to eq('Test')
        expect(user['last_name']).to eq('Tester')
        expect(user['age']).to eq(22)
      end
    end
  end

  context 'PATCH /users/:id' do
    context 'with valid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        age: 22,
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'succeeds' do
        header('Authorization', "Token #{jwt_token}")
        patch_json "/users/#{user.id}", { first_name: 'Test 1',
                                          last_name: 'Tester 1',
                                          age: 23,
                                          email: 'test_1@mail.com',
                                          password_digest: '123456789' }
        expect(last_response.status).to eq(200)
        user = parsed_body
        expect(user['id']).not_to be_nil
        expect(user['first_name']).to eq('Test 1')
        expect(user['last_name']).to eq('Tester 1')
        expect(user['age']).to eq(23)
      end
    end

    context 'with invalid input' do
      let(:user_attributes) do
        App::Services::Password.encrypt(first_name: 'Test',
                                        last_name: 'Tester',
                                        age: 22,
                                        email: 'test@mail.com',
                                        password_digest: '123456789')
      end
      let(:user) { App::Repos::UserRepo.new.create(user_attributes) }

      it 'returns an error' do
        patch_json "/users/#{user.id}", { email: 'test_1@mail.com', password_digest: '123456789' }
        expect(last_response.status).to eq(422)
        user = parsed_body
        expect(user['errors']['first_name']).to include('is missing')
        expect(user['errors']['last_name']).to include('is missing')
      end
    end
  end
end
