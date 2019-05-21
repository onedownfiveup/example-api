# frozen_string_literal: true

require 'rom/sql/rake_task'
require 'rake'
require 'bundler'
Bundler.setup
require 'grape-route-helpers'
require 'grape-route-helpers/tasks'

desc 'load the Sinatra environment.'
task environment: 'app:boot' do
  require 'api/web'
end

namespace :app do
  task :boot do
    require_relative 'boot'
  end
end

namespace :db do
  def task_runner
    return @task_runner if @task_runner

    require 'api/persistence/task_runner'
    config = Example::API::Persistence::CONFIG
    @task_runner = Example::API::Persistence::TaskRunner.new(config.to_h)
  end

  task seed: 'app:boot' do
    load './db/seeds.rb'
  end

  task setup: 'app:boot' do
    require 'api/persistence'
    ROM::SQL::RakeSupport.env = Example::API::Persistence.config
  end

  task create: 'app:boot' do
    task_runner.create_db
  end

  task drop: 'app:boot' do
    task_runner.drop_db
  end

  task reset: 'app:boot' do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  warn 'RSpec Rake task unavailable'
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError
  warn 'RuboCop Rake task unavailable'
end

task test: %i[rubocop spec]
