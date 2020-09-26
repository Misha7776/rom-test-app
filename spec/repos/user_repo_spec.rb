# frozen_string_literal: true

require 'spec_helper'

RSpec.describe App::Repos::UserRepo do
  context '#create' do
    it 'creates a user' do
      user = subject.create(first_name: 'Misha', last_name: 'Push', user_id: 22)

      expect(user).to be_a(App::User)
      expect(user.id).not_to be_nil
      expect(user.first_name).to eq('Misha')
      expect(user.last_name).to eq('Push')
      expect(user.created_at).not_to be_nil
      expect(user.updated_at).not_to be_nil
    end
  end

  context '#all' do
    before do
      subject.create(first_name: 'Misha', last_name: 'Push', age: 22)
    end

    it 'returns all users' do
      users = subject.all
      expect(users.count).to eq(1)
      expect(users.first).to be_a(App::User)
    end
  end
end
