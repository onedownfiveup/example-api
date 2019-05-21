# frozen_string_literal: true

require 'api'
require 'rom'
require 'rom-sql'

module Example::API
  module Persistence
    autoload :Configuration, 'api/persistence/configuration'
    autoload :Relations, 'api/persistence/relations'
    autoload :Repos, 'api/persistence/repos'
    autoload :Timestamps, 'api/persistence/timestamps'

    CONFIG = Configuration.load_file(
      env: ENVIRONMENT,
      fpath: ROOT.join('config/database.yml.erb'),
    )
    MAX_RETRIES = 10

    def self.config(auto_register: true)
      @retries ||= 0
      @config ||= ROM::Configuration.new(:sql, CONFIG.database_url).tap do |config|
        if auto_register
          config.auto_registration(
            Example::API::ROOT.join('lib/api/persistence').to_s,
            namespace: 'Example::API::Persistence',
          )
        end
      end
    rescue Sequel::DatabaseConnectionError
      raise unless CONFIG.retry_connect && @retries < MAX_RETRIES

      @retries += 1
      warn "Retrying DB connection... attempt #@retries/#{MAX_RETRIES}"
      sleep 0.5
      retry
    else
      @retries = nil
      @config
    end

    def self.container(auto_register: true)
      @container ||= ROM.container(config(auto_register: auto_register))
    end
  end
end
