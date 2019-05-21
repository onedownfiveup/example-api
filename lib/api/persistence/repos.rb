# frozen_string_literal: true

require 'api'

module Example::API
  module Persistence::Repos
    autoload :User, 'api/persistence/repos/user'
  end
end
