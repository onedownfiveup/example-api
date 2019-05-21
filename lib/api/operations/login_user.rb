# frozen_string_literal: true

require 'dry/transaction'
require 'jsonapi/serializable'

module Example::API
  class Operations::LoginUser
    include Dry::Transaction

    step :find_user
    step :verify_password

    def find_user(username:, password:)
      Operations::FindUser.new.call({
        username: username,
      }).bind do |result_value|
        Success(user: result_value[:user], password: password)
      end
    end

    def verify_password(user:, password:)
      if Encryptor.compare(user.encrypted_password, password)
        Success(user: user)
      else
        error_text = format('password is incorrect')
        error = Entities::Error.new({detail: error_text, status: :unprocessable_entity})
        Failure([error])
      end
    end
  end
end
