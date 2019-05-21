# frozen_string_literal: true

require 'api'

module Example::API
  class Serialization::Resources::User < JSONAPI::Serializable::Resource
    include CoreExt::Serializable

    type 'users'

    attributes(
      :created_at,
      :email,
      :first_name,
      :last_name,
      :updated_at,
    )

    attribute :created_at do
      @object.created_at.to_s
    end

    attribute :updated_at do
      @object.updated_at.to_s
    end
  end
end
