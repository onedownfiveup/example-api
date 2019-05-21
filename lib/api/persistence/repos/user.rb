# frozen_string_literal: true

require 'api'
require 'rom-repository'

module Example::API
  class Persistence::Repos::User < ROM::Repository[:users]
    prepend Persistence::Timestamps

    commands :create

    def self.new(container = Persistence.container)
      super(container)
    end

    def all
      users.to_a
    end

    def find_by_username(username)
      users
        .by_username(username)
        .map_to(Entities::User)
        .one
    end

    def find(id)
      users.by_pk(id).map_to(Entities::User).one
    end
  end
end
