# frozen_string_literal: true

require 'api'
require 'dry-struct'
require 'dry-validation'
require 'erb'
require 'uri'
require 'yaml'

module Example::API
  class Persistence::Configuration < Dry::Struct::Value
    attribute :adapter, Types::Strict::String
    attribute :host, Types::Strict::String
    attribute :port, Types::Strict::Integer.optional.default(nil)
    attribute :user, Types::Strict::String
    attribute :password, Types::String.optional.default(nil)
    attribute :database, Types::Strict::String
    attribute :retry_connect, Types::Bool.optional.default(nil)

    def self.load_file(env:, fpath:)
      raw = File.read(fpath.to_s)
      template = ERB.new(raw)
      parsed = YAML.safe_load(template.result, [], [], true)
      env_config = parsed.fetch(env).symbolize_keys
      new(env_config).deep_freeze
    end

    def database_url
      URI::Generic.build({
        scheme: adapter,
        host: host,
        port: port,
        userinfo: [user, password].reject(&:nil?).join(':'),
        path: "/#{database}",
      })
    end
  end
end
