require 'pry'

require './lib/onoff'
require './lib/parser'

namespace :db do
  desc "Create database"
  task create: [ :set_env_vars ] do
    query = "CREATE DATABASE #{OnOff::API.application.db_vars['database']} WITH OWNER #{OnOff::API.application.db_vars['username']}"

    exec_psql_query(query)
  end

  desc "Drop database"
  task drop: [ :set_env_vars ] do
    query = "DROP DATABASE IF EXISTS #{OnOff::API.application.db_vars['database']}"

    exec_psql_query(query)
  end

  desc "Reset database"
  task reset: [ :drop, :create, :migrate, :seeds ] do
    # Rake::Task['db:drop']
    # Rake::Task['db:create']
    # Rake::Task['db:migrate']
    # Rake::Task['db:seeds']
  end

  desc "Load seeds"
  task :seeds do
    require './db/seeds'

    seeds_loader = OnOff::API::DB::SeedsLoader.new
  end

  desc "Import data from spreadsheet to database"
  task :import, :filename do |task, args|
    args.with_defaults(filename: 'spreadsheets/DBex.ods')

    parser = OnOff::API::Parser.new
    parser.parse(args[:filename])
  end

  desc "Migrate database"
  task :migrate do
    DataMapper.finalize
    DataMapper.auto_migrate!
    DataMapper.auto_upgrade!
  end

  desc "Check for DB existence"
  task check_existence: [ :set_env_vars ] do
    query = "SELECT 1 FROM pg_database WHERE datname='#{OnOff::API.application.db_vars['database']}'"

    exec_psql_query(query)
  end

  desc "Set environment variables"
  task :set_env_vars do
    set_env_vars(OnOff::API.application.db_vars)
  end

  def exec_psql_query(query)
    exec psql_query(query)
  end

  def psql_query(query)
    "psql -c #{quoterize(query)}"
  end

  def quoterize(query)
    "\"#{query}\""
  end

  def set_env_vars(config)
    ENV['PGHOST'] = config['host']
    ENV['PGPORT'] = config['port'].to_s
    ENV['PGDATABASE'] = config['template']
    ENV['PGUSER'] = config['username']
    ENV['PGPASSWORD'] = config['password'].to_s
  end
end