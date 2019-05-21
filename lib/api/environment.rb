# frozen_string_literal: true

module Example
  module API
    KNOWN_ENVIRONMENTS = %w[development production test].freeze
    private_constant :KNOWN_ENVIRONMENTS
    ENVIRONMENT = ENV.fetch('APP_ENV').strip.freeze

    unless KNOWN_ENVIRONMENTS.include?(ENVIRONMENT)
      raise "APP_ENV (#{ENVIRONMENT}) is not in known list (#{KNOWN_ENVIRONMENTS.inspect})"
    end
  end
end
