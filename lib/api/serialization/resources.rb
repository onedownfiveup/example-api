# frozen_string_literal: true

require 'api'

module Example::API
  module Serialization::Resources
    autoload :Error, 'api/serialization/resources/error'
    autoload :User, 'api/serialization/resources/User'
  end
end
