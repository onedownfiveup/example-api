# frozen_string_literal: true

require 'grape'
require 'api'

module Example::API
  class Web::V1::Users < Grape::API
    resource :users do
      get ':id' do
        with_authentication do
          users_repo = Persistence::Repos::User.new
          user_rom = users_repo.find(params[:id])

          Serialization::Renderer.render(user_rom)
        end
      end

      post 'login' do
        user = warden.authenticate!
        Serialization::Renderer.render(user)
      end

      post do
        params.delete(:id)
        result = Operations::CreateUser.new.call(
          user_attributes: params,
        )
        result_data = if result.success?
          status(:ok)
          result.success
        else
          status(result.failure.first.status)
          result.failure
        end

        Serialization::Renderer.render(result_data)
      end
    end
  end
end
