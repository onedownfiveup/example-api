# frozen_string_literal: true

require 'logger'
require 'shellwords'
require 'api'

module Example::API
  class Persistence::TaskRunner
    MAX_RETRIES = 10

    def initialize(db_config)
      @db_config = db_config
    end

    def create_db
      return if db_exists?
      management_connection.run "CREATE DATABASE #{@db_config[:database]}"
    end

    def drop_db
      return unless db_exists?
      connection.disconnect
      management_connection.run "DROP DATABASE IF EXISTS #{@db_config[:database]}"
    end

    private

    def connection
      @connection ||= Persistence.container(auto_register: false).gateways[:default].connection
    end

    def management_connection
      @retries ||= 0
      @management_connection ||= Sequel.connect(@db_config.merge(database: 'postgres')).tap do |connection|
        connection.loggers = [Example::API.logger]
      end
    rescue Sequel::DatabaseConnectionError
      raise unless @retries < MAX_RETRIES

      @retries += 1
      warn "Retrying DB connection... attempt #@retries/#{MAX_RETRIES}"
      sleep 0.5
      retry
    else
      @retries = nil
      @management_connection
    end

    def db_exists?
      management_connection[:pg_database]
        .where(datname: @db_config[:database])
        .any?
    end
  end
end
