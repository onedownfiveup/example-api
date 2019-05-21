# frozen_string_literal: true

require 'api'
require 'dry-validation'

module Example::API
  module Validations
    class User < Dry::Validation::Contract
      params do
        required(:email).filled
        required(:first_name).filled
        required(:last_name).filled
        required(:password).filled
      end

      def self.validate(attributes)
        new.call(attributes)
      end
    end
  end
end
