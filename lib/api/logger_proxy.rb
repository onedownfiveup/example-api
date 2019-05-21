# frozen_string_literal: true

require 'api'
require 'delegate'
require 'singleton'

module Example::API
  class LoggerProxy < SimpleDelegator
    include Singleton

    def initialize(backend = ::Logger.new($stderr))
      super(backend)
    end
  end
end
