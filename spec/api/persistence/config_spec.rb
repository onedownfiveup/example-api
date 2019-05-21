# frozen_string_literal: true

require 'spec_helper'
require 'api'

RSpec.describe 'Example::API::Persistence::CONFIG' do
  let(:config) { Example::API::Persistence::CONFIG }

  it 'blows up on access to non-existent keys' do
    expect { config.foo }.to raise_error NoMethodError, /foo/
  end

  it 'does not allow mutation' do
    expect { config.database = nil }.to raise_error NoMethodError, /database/
  end
end
