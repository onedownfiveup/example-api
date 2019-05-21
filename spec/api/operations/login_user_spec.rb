# frozen_string_literal: true

require 'spec_helper'
require 'api'
require 'securerandom'

module Example::API
  RSpec.describe Operations::LoginUser do
    def call(*args)
      described_class.new.call(*args)
    end

    let(:password) { 'securepassword' }
    let!(:user) do
      Factory[:user,
              email: 'gus@Example.com',
              encrypted_password: Encryptor.digest(password)
      ]
    end

    it 'returns an error if user is not found' do
      result = call(
        username: 'nonexistant@mail.com',
        password: password,
      )
      expect(result).to_not be_success

      expect(result.failure.map(&:to_h)).to match([hash_including({
        id: anything,
        status: :not_found,
        detail: 'user nonexistant@mail.com not found',
      })])
    end

    it 'returns an error if password is incorrect' do
      result = call(
        username: 'gus@Example.com',
        password: 'passtheword',
      )
      expect(result).to_not be_success

      expect(result.failure.map(&:to_h)).to match([hash_including({
        id: anything,
        status: :unprocessable_entity,
        detail: 'password is incorrect',
      })])
    end

    it 'returns the user if the user logged in succesfully' do
      result = call(
        username: 'gus@Example.com',
        password: password,
      )
      expect(result).to be_success

      expect(result.success[:user]).to be_a Entities::User
      expect(result.success[:user].id).to eq user.id
    end
  end
end
