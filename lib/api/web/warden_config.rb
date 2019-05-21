# frozen_string_literal

module Example::API
	class Web::WardenConfig
		def self.init
			Warden::Strategies.add(:password) do
				def valid?
          params['username'] && params['password']
				end

				def authenticate!
          result = Example::API::Operations::LoginUser.new.call(
            username: params['username'],
            password: params['password']
          )
          if result.success?
            success!(result.success[:user])
          end
				end
			end
		end

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      repo = Persistence::Repos::User.new
      repo.find(id)
    end
	end
end
