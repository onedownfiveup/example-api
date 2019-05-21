# frozen_string_literal: true

require 'spec_helper'
require 'api'

RSpec.describe Example::API::Web::V1 do
  include SpecHelper::Integration

  let(:email) { 'beansauce@example.org' }
  let(:record) do
    {
      'email': email,
      'first_name': 'Bean',
      'last_name': 'Sauce',
    }
  end
  let(:password) do
    {
      'password': 'password',
      'password_confirmation': 'password',
    }
  end

  let(:record_with_password) { record.merge(password) }

  before do
    header 'Accept', 'application/vnd.api+json'
    header 'Accept-Version', 'v1'
    header 'Content-Type', 'application/vnd.api+json'
  end

  describe 'POST /v1/users/login' do
    it 'logs in a user and returns the user json' do
      password = 'password'

      user = Factory[
        :user,
        first_name: 'Bean',
        last_name: 'Sauce',
        email: 'foo@example.com',
        encrypted_password: Example::API::Encryptor.digest(password),
      ]

      post '/users/login', {username: user.email, password: password}.to_json
      expect(JSON.parse(last_response.body)).to match({
        'data' => {
          'id' => be_uuid,
          'type' => 'users',
          'attributes' => {
            'email' => user.email,
            'created_at' => be_valid_time_string,
            'updated_at' => be_valid_time_string,
            'first_name' => user.first_name,
            'last_name' => user.last_name,
          },
        },
      })
    end
  end

  describe 'GET /v1/users/:user_id' do
    it 'returns a 401 if the user is not logged in' do
      user = Factory[
        :user,
        first_name: 'Bean',
        last_name: 'Sauce',
        email: 'foo@example.com',
      ]

      get "/users/#{user.id}"
      expect(last_response.status).to eq 401
    end

    it 'gets specific user' do
      user = Factory[
        :user,
        first_name: 'Bean',
        last_name: 'Sauce',
        email: 'foo@example.com',
      ]

      login_as user
      get "/users/#{user.id}"

      expect(JSON.parse(last_response.body)).to match({
        'data' => {
          'id' => be_uuid,
          'type' => 'users',
          'attributes' => {
            'email' => user.email,
            'created_at' => be_valid_time_string,
            'updated_at' => be_valid_time_string,
            'first_name' => user.first_name,
            'last_name' => user.last_name,
          },
        },
      })
      expect(last_response.status).to eq 200
    end
  end

  describe 'POST /v1/users' do
    it 'indicates success when user is valid' do
      post '/users', record_with_password.to_json
      expect(last_response.status).to eq 200
    end

    it 'returns the user record' do
      post '/users', record_with_password.to_json

      expect(JSON.parse(last_response.body)).to match({
        'data' => {
          'id' => be_uuid,
          'type' => 'users',
          'attributes' => {
            'email' => email,
            'created_at' => be_valid_time_string,
            'updated_at' => be_valid_time_string,
            'first_name' => 'Bean',
            'last_name' => 'Sauce',
          },
        },
      })
    end

    it 'persists the record' do
      post '/users', record_with_password.to_json

      users_repo = Example::API::Persistence::Repos::User.new
      user = users_repo.find_by_username(email)

      expect(user.to_h).to include({
        email: email,
        first_name: 'Bean',
        last_name: 'Sauce',
        created_at: be_a(Time),
        updated_at: be_a(Time),
      })
    end

    it 'fails when not given required params' do
      post '/users', {}.to_json
      expect(last_response.status).to eq 422
    end

    it 'ignores unallowed params' do
      input_uuid = SecureRandom.uuid
      post '/users', record_with_password.merge(
        'id': input_uuid,
      ).to_json

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)['data']['id']).to_not eq input_uuid
    end
  end
end
