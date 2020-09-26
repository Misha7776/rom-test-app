# frozen_string_literal: true

require 'spec_helper'

RSpec.describe App::Repos::PostRepo do
  context '#create' do
    let(:user) do
      App::Repos::UserRepo.new.create(first_name: 'Test',
                                      last_name: 'Tester',
                                      email: 'test@mail.com',
                                      password_digest: '123456789')
    end
    let(:post) { subject.create(title: 'Test title', body: 'test body', user_id: user.id) }

    it 'creates a user' do
      expect(post).to be_a(App::Post)
      expect(post.id).not_to be_nil
      expect(post.title).to eq('Test title')
      expect(post.body).to eq('test body')
      expect(post.created_at).not_to be_nil
      expect(post.updated_at).not_to be_nil
    end
  end

  context '#all' do
    let(:user) { App::Repos::UserRepo.new.create(first_name: 'Test', last_name: 'Tester') }

    before do
      subject.create(title: 'Test title', body: 'test body', user_id: user.id)
    end

    it 'returns all users' do
      posts = subject.all
      expect(posts.count).to eq(1)
      expect(posts.first).to be_a(App::Post)
    end
  end
end
