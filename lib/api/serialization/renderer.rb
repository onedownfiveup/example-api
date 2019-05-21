# frozen_string_literal: true

require 'api'
require 'jsonapi/serializable'

module Example::API
  class Serialization::Renderer
    def self.render(input)
      renderer = JSONAPI::Serializable::Renderer.new
      if error_renderers.key?(Array.wrap(input).first.class.name.to_sym)
        renderer.render_errors(input, class: error_renderers)
      else
        renderer.render(input, class: data_renderers)
      end
    end

    def self.data_renderers
      @data_renderers ||= {
        Entities::User.name.to_sym => Serialization::Resources::User,
      }.deep_freeze
    end

    def self.error_renderers
      @error_renderers ||= {
        Entities::Error.name.to_sym => Serialization::Resources::Error,
      }.deep_freeze
    end
  end
end
