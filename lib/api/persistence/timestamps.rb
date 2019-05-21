# frozen_string_literal: true

require 'api'

module Example::API
  module Persistence::Timestamps
    def create(attrs)
      attrs.delete(:created_at) if attrs[:created_at].nil?
      attrs.delete(:updated_at) if attrs[:updated_at].nil?
      super root.changeset(:create, attrs).map(:add_timestamps)
    end

    def update(id, attrs)
      super root.by_pk(id).changeset(:update, attrs).map(:touch)
    end
  end
end
