# frozen_string_literal: true

require 'dry/transaction'
require 'jsonapi/serializable'

module Example::API
  class Operations::FindUser
    include Dry::Transaction

    step :find

    def find(username:)
      repo = Persistence::Repos::User.new
      user = repo.find_by_username(username)

      if user
        Success(user: user)
      else
        error_text = format('user %s not found', username)
        error = Entities::Error.new({detail: error_text, status: :not_found})
        Failure([error])
      end
    end
  end
end
