# frozen_string_literal: true

require 'spec_helper'

RSpec.describe App::Transactions::Posts::CreatePost do
  let(:post_repo) { double('PostRepo') }
  let(:post) { App::Post.new(id: 1, title: 'Initial post', body: 'Posts body') }

  # Here we use the dry-auto_inject dependency injection
  # without hitting the database we can test the transaction
  subject { described_class.new(post_repo: post_repo) }

  context 'with valid input' do
    let(:input) { { title: 'Initial post', body: 'Posts body', user_id: 22 } }


    it 'creates a user' do
      expect(post_repo).to receive(:create) { post }
      result = subject.call(input)
      expect(result).to be_success
      expect(result.success).to eq(post)
    end
  end

  context 'with invalid input' do
    let(:input) { { user_id: 22 } }

    it 'does not create a user' do
      expect(post_repo).not_to receive(:create)
      result = subject.call(input)
      expect(result).to be_failure
      expect(result.failure.errors[:title]).to include('is missing')
      expect(result.failure.errors[:body]).to include('is missing')
    end
  end
end
