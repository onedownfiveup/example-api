# frozen_string_literal: true

Factory.define(:user) do |f|
  f.sequence :id do |_n|
    SecureRandom.uuid
  end

  f.first_name { Faker::Name.first_name }
  f.last_name { Faker::Name.last_name }
  f.email { Faker::Internet.email }
  f.encrypted_password { Example::API::Encryptor.digest('password') }

  f.timestamps
end
