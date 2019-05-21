# frozen_string_literal: true

require 'api'

module Example::API
  module Serialization
    autoload :Renderer, 'api/serialization/renderer.rb'
    autoload :Resources, 'api/serialization/resources.rb'
  end
end
