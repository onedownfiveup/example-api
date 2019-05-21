# frozen_string_literal: true

require 'api'
require 'database_cleaner'

connection = Example::API::Persistence.container.gateways[:default].connection
database_cleaner = DatabaseCleaner[:sequel, connection: connection]

RSpec.configure do |config|
  config.before(:suite) do
    database_cleaner.strategy = :transaction
    database_cleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    database_cleaner.start
    example.run
    database_cleaner.clean
  end
end
