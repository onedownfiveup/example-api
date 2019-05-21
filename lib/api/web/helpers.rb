# frozen_string_literal: true

module Example::API
  module Web::Helpers
    def with_authentication(&_block)
      if warden.authenticated?
        yield
      else
        status(:unauthorized)
      end
    end

    def warden
      env['warden']
    end
  end
end
