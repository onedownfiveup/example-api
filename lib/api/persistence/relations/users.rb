# frozen_string_literal: true

require 'api'

module Example::API
  class Persistence::Relations::Users < ROM::Relation[:sql]
    schema(:users, infer: true)

    def by_username(username)
      where(email: username)
    end
  end
end
