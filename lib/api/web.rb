# frozen_string_literal: true

require 'grape'
require 'api'
require 'warden'

module Example::API
  class Web < Grape::API
    autoload :V1, 'api/web/v1'
    autoload :HealthCheck, 'api/web/health_check'
    autoload :Routes, 'api/web/routes'
    autoload :Helpers, 'api/web/helpers'
    autoload :AuthMiddleware, 'api/web/auth_middleware'
    autoload :UnauthorizedMiddleware, 'api/web/unauthorized_middleware'

    format :json
    content_type :json, 'application/vnd.api+json; charset=utf-8'
    helpers Web::Helpers

    use Rack::Session::Cookie, secret: 'TODO: replace this with some secret key'

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = Example::API::Web
      manager.intercept_401 = false
    end

    Warden::Strategies.add(:password) do
      def valid?
        params['username'] && params['password']
      end

      def authenticate!
        result = Example::API::Operations::LoginUser.new.call(
          username: params['username'],
          password: params['password'],
        )
        if result.success?
          success!(result.success[:user])
        else
          fail!
        end
      end
    end

    Warden::Manager.serialize_into_session(&:id)

    Warden::Manager.serialize_from_session do |id|
      repo = Persistence::Repos::User.new
      repo.find(id)
    end

    mount Web::V1
    mount Web::HealthCheck

    BASE_URL = ENV['APP_BASE_URL'].freeze

    def self.base_url
      BASE_URL
    end
  end
end
