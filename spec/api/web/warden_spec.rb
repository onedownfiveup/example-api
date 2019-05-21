# frozen_string_literal: true

require 'spec_helper'
require 'api'

RSpec.describe 'Warden authentication' do
  include SpecHelper::Integration

  module Example::API
    class Web::V1::TestShit < Grape::API
      resource :test_shit do
        post do
          env['warden'].authenticate! action: 'test_shit/unauthenticated'
          status(:ok)
          {foo: 'foo'}
        end

        get '/current_user' do
          if env['warden'].authenticated?
            status(:ok)
            env['warden'].user.to_h
          else
            status(:unauthorized)
          end
        end

        get '/authenticated' do
          if env['warden'].authenticated?
            status(:ok)
          else
            status(:unauthorized)
          end
        end

        post 'unauthenticated' do
          status(:unauthorized)
          {error: 'Unauthorized'}
        end
      end
    end

    class Web::V1 < Grape::API
      use Rack::Session::Cookie, secret: 'TODO: replace this with some secret key'
      mount Web::V1::TestShit
    end
  end

  context 'successfull' do
    let!(:user) { Factory[:user] }
    let!(:result_double) { double(success?: true, success: {user: user}) }
    let!(:operation_double) { double(call: result_double) }

    before do
      allow(Example::API::Operations::LoginUser)
        .to(receive(:new))
        .and_return(operation_double)
    end

    it 'authenticates the user and allows them to access endpoints that require authentication' do
      post '/test_shit', {username: 'foo', password: 'secure shit'}
      expect(last_response.status).to eq 200

      get '/test_shit/authenticated'
      expect(last_response.status).to eq 200
    end

    it 'returns the user id of the logged in user' do
      post '/test_shit', {username: 'foo', password: 'secure shit'}
      get '/test_shit/current_user'

      expect(JSON.parse(last_response.body)).to include({
        'id' => user.id,
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'email' => user.email,
        'created_at' => be_valid_time_string,
        'updated_at' => be_valid_time_string,
      })
    end
  end

  it 'returns a 401 if username and password parameters not passed' do
    post '/test_shit'
    expect(last_response.status).to eq 401
  end
end
