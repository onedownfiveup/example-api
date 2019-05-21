# frozen_string_literal: true

require 'spec_helper'
require 'api'
require 'api/entities'

module Example::API
  RSpec.describe Entities::User do
    it 'sets the password' do
      user = Entities::User.new(password: 'foo')
      expect(user.encrypted_password).to_not be_nil
    end
  end
end
