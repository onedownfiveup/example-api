# frozen_string_literal: true

module Example::API
  module Web::Helpers
    def with_authentication(&block)
      if warden.authenticated?
        block.call
      else
        status(:unauthorized)
      end
    end

    def warden
      env['warden']
    end
  end
end
