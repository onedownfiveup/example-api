# frozen_string_literal: true

require 'spec_helper'
require 'api'
require 'securerandom'

module Example::API
  RSpec.describe Operations::FindUser do
    def call(*args)
      described_class.new.call(*args)
    end

    let!(:user) { Factory[:user] }

    it 'finds the user with a particular username' do
      result = call(username: user.email)
      expect(result).to be_success
      expect(result.success[:user].id).to eq user.id
    end

    it 'populates error if user is not found' do
      result = call(username: 'nonexistant@mail.com')
      expect(result).to_not be_success

      expect(result.failure.map(&:to_h)).to match([hash_including({
        id: anything,
        status: :not_found,
        detail: 'user nonexistant@mail.com not found',
      })])
    end
  end
end
