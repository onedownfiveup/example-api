# frozen_string_literal: true

require 'grape-route-helpers'
require 'uri'

module Example::API
  module Web::Routes
    extend GrapeRouteHelpers::NamedRouteMatcher

    def self.path_for(name)
      public_send(:"#{name}_path")
    rescue NoMethodError
      raise "not a known pathspec: #{name}"
    end

    def self.url_for(name)
      uri = URI.parse(Web.base_url)
      uri.path += path_for(name)
      uri.to_s
    end
  end
end
