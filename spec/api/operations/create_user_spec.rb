# frozen_string_literal: true

require 'spec_helper'
require 'api'
require 'api/entities'
require 'securerandom'

module Example::API
  RSpec.describe Operations::CreateUser do
    def call(*args)
      described_class.new.call(*args)
    end

    it 'returns an error if user fails validation' do
      result = call(user_attributes: {})
      expect(result).to be_failure
      expect(result.failure.map(&:code)).to match(
        %i[
          email
          first_name
          last_name
          password
        ],
      )
    end

    it 'returns the user that was created' do
      result = call(user_attributes: {
        email: 'gmav@user.ninja',
        first_name: 'Gus',
        last_name: 'user',
        password: 'Fudtucker2',
      })
      expect(result).to be_success

      user_repo = Persistence::Repos::User.new
      user = user_repo.find_by_username('gmav@user.ninja')
      expect(result.success).to eq user
    end
  end
end
