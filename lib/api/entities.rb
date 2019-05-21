# frozen_string_literal: true

require 'api'

module Example::API
  module Entities
    autoload :Error, 'api/entities/error'
    autoload :User, 'api/entities/user'
  end
end
