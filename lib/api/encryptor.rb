# frozen_string_literal: true

require 'bcrypt'

module Example::API
  module Encryptor
    # rubocop:disable LineLength
    PEPPER = 'NL2gfsrFGinEB8XutQWt6OEXiRS-KQzOYCQGi5CT-dfmtvGXMo3KSIJH0JqSSEEUlM51wdTl6RBGM87GOmEkXgIVwizz7MOCZwpk5LSzImxc-QynamVoScQqsCnxNArC'
    # rubocop:enable LineLength
    #
    COST = 11

    def self.digest(password)
      password = "#{password}#{PEPPER}"
      BCrypt::Password.create(password, cost: COST).to_s
    end

    def self.compare(hashed_password, password)
      return false if hashed_password.empty?
      bcrypt   = BCrypt::Password.new(hashed_password)
      password = "#{password}#{PEPPER}"
      password = BCrypt::Engine.hash_secret(password, bcrypt.salt)
      secure_compare(password, hashed_password)
    end

    # constant-time comparison algorithm to prevent timing attacks
    def self.secure_compare(password, hashed_password)
      return false if password.empty? || hashed_password.empty? || password.bytesize != hashed_password.bytesize
      l = password.unpack "C#{password.bytesize}"

      res = 0
      hashed_password.each_byte { |byte| res |= byte ^ l.shift }

      res.zero?
    end
  end
end
