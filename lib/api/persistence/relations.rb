# frozen_string_literal: true

require 'api'

module Example::API
  module Persistence::Relations
    autoload :Users, 'api/persistence/relations/users'
  end
end
