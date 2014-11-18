ENV['API_ENV'] = 'test'

[ '../lib/onoff', '../lib/parser/catalogue.rb', '../lib/parser/prices.rb' ].each do |file|
  require File.expand_path(file, File.dirname(__FILE__))
end

require 'rack/test'
require 'database_cleaner'
require 'rspec/expectations'
require 'dm-rspec'
require 'factory_girl'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |file| require file }

module RSpecMixin
  include Rack::Test::Methods

  def app
    OnOff::API::Routes::Main
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end

  begin
    config.filter_run :focus
    config.run_all_when_everything_filtered = true

    config.disable_monkey_patching!

    config.warnings = false

    if config.files_to_run.one?
      config.default_formatter = 'doc'
    end

    config.profile_examples = 10

    config.order = :random

    Kernel.srand config.seed

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.include RSpecMixin
    config.include DataMapper::Matchers
    config.include FactoryGirl::Syntax::Methods
  end
end