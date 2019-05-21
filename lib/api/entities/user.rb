# frozen_string_literal: true

require 'api'
require 'dry-struct'
require 'securerandom'

module Example::API
  class Entities::User < Dry::Struct
    transform_keys(&:to_sym)

    attribute :created_at, Types::Time.optional.default(nil)
    attribute :email, Types::Strict::String.optional.default(nil)
    attribute :encrypted_password, Types::Strict::String.optional.default(nil)
    attribute :first_name, Types::Strict::String.optional.default(nil)
    attribute :id, Types::String.default(SecureRandom.uuid.freeze)
    attribute :last_name, Types::Strict::String.optional.default(nil)
    attribute :updated_at, Types::Time.optional.default(nil)

    def self.new(params)
      if params && params[:password]
        params[:encrypted_password] = Encryptor.digest(params[:password])
      end

      super(params)
    end
  end
end
