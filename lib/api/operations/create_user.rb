# frozen_string_literal: true

require 'dry/transaction'

module Example::API
  class Operations::CreateUser
    include Dry::Transaction

    step :validate_attributes
    step :create_entity
    step :save_to_database

    def validate_attributes(user_attributes:)
      result = Validations::User.validate(user_attributes)
      if result.success?
        Success(user_attributes)
      else
        errors = []

        result.errors.each do |error|
          errors << Entities::Error.new(
            status: :unprocessable_entity,
            code: error.path[0],
            detail: error.text,
          )
        end

        Failure(errors)
      end
    end

    def create_entity(attributes)
      Success(Entities::User.new(attributes))
    end

    def save_to_database(user)
      user_repo = Persistence::Repos::User.new

      user_rom = user_repo.create(user.to_h)
      user = user.new(user_rom.to_h)

      Success(user)
    end
  end
end
