# frozen_string_literal: true

require 'grape'
require 'api'

module Example::API
  class Web::HealthCheck < Grape::API
    resource :health_check do
      get do
        {'status' => 'ok'}
      end
    end
  end
end
