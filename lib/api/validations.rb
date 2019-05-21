# frozen_string_literal: true

require 'api'
require 'dry/validation'

module Example::API
  module Validations
    autoload :User, 'api/validations/user'
  end
end
