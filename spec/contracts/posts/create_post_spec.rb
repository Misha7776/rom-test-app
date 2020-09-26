# frozen_string_literal: true

require 'spec_helper'

RSpec.describe App::Contracts::Posts::CreatePost do
  context 'requires title' do
    let(:input) { { body: 'ROM & DRY are a new way of developing Ruby applications', user_id: 1 } }
    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:title]).to include('is missing')
    end
  end

  context 'requires body' do
    let(:input) { { title: 'About ROM & DRY', user_id: 1 } }
    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:body]).to include('is missing')
    end
  end

  context 'requires user_id' do
    let(:input) { { title: 'About ROM & DRY', body: 'ROM & DRY are a new way of developing Ruby applications' } }
    let(:result) { subject.call(input) }

    it 'is invalid' do
      expect(result).to be_failure
      expect(result.errors[:user_id]).to include('is missing')
    end
  end

  context 'given valid parameters' do
    let(:input) do
      { title: 'About ROM & DRY',
        body: 'ROM & DRY are a new way of developing Ruby applications',
        user_id: 1 }
    end

    let(:result) { subject.call(input) }

    it 'is valid' do
      expect(result).to be_success
    end
  end
end
