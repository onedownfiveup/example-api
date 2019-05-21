# frozen_string_literal: true

require 'jsonapi/serializable'

module Example::API
  class Serialization::Resources::Error < JSONAPI::Serializable::Error
    include CoreExt::Serializable

    id { @object[:id] }
    detail { @object[:detail] }
    status { @object[:status] }
    code { @object[:code] }
  end
end
