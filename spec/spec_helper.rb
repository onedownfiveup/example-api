# frozen_string_literal: true

require 'rom'
require 'rom/factory'
require 'warden/test/helpers'

ENV['APP_ENV'] = 'test'
require_relative '../boot'

RSpec.configure do |config|
  config.backtrace_exclusion_patterns << /^#{ENV['BUNDLE_PATH']}\b/
  config.disable_monkey_patching!
  config.order = :random

  config.include Warden::Test::Helpers

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.mock_with(:rspec) do |c|
    c.syntax = :expect
  end

  if ENV['CI']
    config.fail_if_no_examples = true
  end
end

module SpecHelper
  autoload :Integration, 'support/integration'
end

require 'api/persistence'
Factory = ROM::Factory.configure do |config|
  config.rom = Example::API::Persistence.container
end

require 'pry'
require 'support/database_cleaner'
require 'support/factories'
require 'support/matchers'
require 'support/timecop'
