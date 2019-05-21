# frozen_string_literal: true

require 'spec_helper'
require 'api'

RSpec.describe Example::API::Web do
  include SpecHelper::Integration

  it 'says hello' do
    get '/health_check'
    expect(last_response.status).to eq 200
    expect(JSON.parse(last_response.body)).to eq({'status' => 'ok'})
  end
end
