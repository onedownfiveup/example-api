# frozen_string_literal: true

source 'https://rubygems.org'

ruby '~> 2.5.5'

gem 'bcrypt'
gem 'dotenv'
gem 'dry-configurable'
gem 'dry-transaction'
gem 'dry-types'
gem 'dry-validation', '~> 1.0.0.rc3'
gem 'grape'
gem 'grape-route-helpers'
gem 'hashie'
gem 'ice_nine'
gem 'json'
gem 'jsonapi-rb'
gem 'pg'
gem 'rack-cors'
gem 'rack-protection'
gem 'rom', '~> 5.0', '>= 5.0.2'
gem 'rom-repository'
gem 'rom-sql'
gem 'warden'

group :development do
  gem 'shotgun'
end

group :test do
  gem 'database_cleaner'
  gem 'rack-test'
  gem 'rom-factory'
  gem 'rspec'
  gem 'timecop'
end

group :production do
  gem 'puma'
end

group :development, :test do
  gem 'lint-config-ruby', git: 'https://github.com/onedownfiveup/lint-config-ruby-1.git'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-theme'
  gem 'rubocop'
end
