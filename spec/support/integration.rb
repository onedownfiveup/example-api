# frozen_string_literal: true

require 'rack/test'

module SpecHelper
  module Integration
    include Rack::Test::Methods

    def app
      Example::API::Web
    end
  end
end
