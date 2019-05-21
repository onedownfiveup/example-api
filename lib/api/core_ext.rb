# frozen_string_literal: true

require 'ice_nine'
require 'ice_nine/core_ext/object'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/date/calculations'

module Example::API
  module CoreExt
    module TimeExtension
      def to_json(*args, &block)
        iso8601.to_json(*args, &block)
      end
    end

    module JsonApiRendererExtension
      def _build(object, exposures, klass, &block)
        class_name = object.class.name.to_sym
        unless klass.key?(class_name)
          raise "class not in renderer :class mapping: #{class_name.inspect}"
        end

        super
      end
    end

    module Serializable
    end
  end
end

require 'time'

class DateTime
  prepend Example::API::CoreExt::TimeExtension
end

class Time
  prepend Example::API::CoreExt::TimeExtension
end

require 'jsonapi/serializable/renderer'
class JSONAPI::Serializable::Renderer
  prepend Example::API::CoreExt::JsonApiRendererExtension
end
