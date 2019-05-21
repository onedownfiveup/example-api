# frozen_string_literal: true

require 'grape'
require 'api'

module Example::API
  class Web::V1 < Grape::API
    VERSION_LONG = '1.0.0-pre'
    VERSION_SHORT = VERSION_LONG.split('.', 2).first.freeze

    autoload :Users, 'api/web/v1/users'

    version "v#{VERSION_SHORT}", using: :accept_version_header
    mount Web::V1::Users
  end
end
