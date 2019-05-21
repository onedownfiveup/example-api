# frozen_string_literal: true

require_relative './boot'
require 'api/web'
require 'rack/cors'
require 'rack/protection'

use Rack::Runtime
use Rack::Protection::FrameOptions
use Rack::Protection::IPSpoofing
use Rack::Protection::PathTraversal
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

run Example::API::Web
