# frozen_string_literal: true

require 'api'
require 'dry/monads/result'
require 'dry/transaction/step_adapters'

module Example::API
  module Operations
    autoload :CreateUser, 'api/operations/create_user'
    autoload :FindUser, 'api/operations/find_user'
    autoload :LoginUser, 'api/operations/login_user'
    autoload :VerifyApiCredentials, 'api/operations/verify_api_credentials'
  end
end
