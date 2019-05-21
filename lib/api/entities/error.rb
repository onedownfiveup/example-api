# frozen_string_literal: true

require 'api'
require 'dry-struct'
require 'rack/utils'
require 'securerandom'

module Example::API
  class Entities::Error < Dry::Struct
    attribute(:id, Types::Strict::String.default { SecureRandom.uuid })
    attribute :code, Types::Strict::Symbol.optional.default(nil)
    attribute :detail, Types::Strict::String.optional.default(nil)
    attribute(
      :status,
      Types::Strict::Symbol.enum(*Rack::Utils::SYMBOL_TO_STATUS_CODE.keys).optional.default(nil),
    )
  end
end
