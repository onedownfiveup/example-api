# frozen_string_literal: true

module Example
  module API
    autoload :Configurable, 'api/configurable'
    autoload :Configuration, 'api/configuration'
    autoload :ENVIRONMENT, 'api/environment'
    autoload :Encryptor, 'api/encryptor'
    autoload :Entities, 'api/entities'
    autoload :LoggerProxy, 'api/logger_proxy'
    autoload :Operations, 'api/operations'
    autoload :Persistence, 'api/persistence'
    autoload :ROOT, 'api/root'
    autoload :Serialization, 'api/serialization'
    autoload :Types, 'api/types'
    autoload :Validations, 'api/validations'
    autoload :Web, 'api/web'

    require 'api/core_ext'

    def self.logger
      LoggerProxy.instance
    end

    def self.logger=(backend)
      LoggerProxy.__setobj__(backend)
    end
  end
end
