# frozen_string_literal: true

if defined?(Process::CLOCK_MONOTONIC)
  start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
end

require 'bundler'
$LOAD_PATH.push(File.expand_path('lib', __dir__))

require 'dotenv/load'
require 'api/environment'

warn "Running Example::API in #{Example::API::ENVIRONMENT}"
Bundler.setup(:default, Example::API::ENVIRONMENT)

if defined?(Process::CLOCK_MONOTONIC)
  end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  duration = end_time - start_time
  $stderr.printf("Booted in %.2f seconds\n", duration)
end
