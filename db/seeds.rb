# frozen_string_literal: true

require 'api'

module Example::API
  puts '<= seeding the database'

  seeds = {
    users: [
      {
        email: 'gus@user',
        first_name: 'Gus',
        last_name: 'Mavromoustakos',
        encrypted_password: Encryptor.digest('password')
      },
    ],
  }.deep_freeze

  users_repo = Persistence::Repos::User.new(Persistence.container)

  seeds[:users].each do |user|
    entity = Entities::User.new(user)
    users_repo.create(entity.to_h.compact)
  end
end
