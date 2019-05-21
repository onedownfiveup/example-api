# frozen_string_literal: true

require 'timecop'

RSpec.configure do |config|
  config.after do
    defined?(Timecop) and Timecop.return
  end
end
