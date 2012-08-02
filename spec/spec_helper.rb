require 'rspec'
require 'rails'
require 'mongoid'
require 'spork'
# require 'factory_girl'

Spork.prefork do
  # Configure Rails Envinronment
  ENV["RAILS_ENV"] = "test"

  # config_dir = File.expand_path("../../config",  __FILE__)
  # mongoid_yml = File.join(config_dir, 'mongoid.yml')
  # puts "mongoid.yml: #{mongoid_yml}"
  # Mongoid.load! mongoid_yml

  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require "rails/test_help"
  require "rspec/rails"

  Rails.backtrace_cleaner.remove_silencers!

  # Configure capybara for integration testing
  require "capybara/rails"
  Capybara.default_driver   = :rack_test

  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  require 'carrierwave/test/matchers'

  RSpec.configure do |config|
    # Remove this line if you don't want RSpec's should and should_not
    # methods or matchers
    require 'rspec/expectations'
    config.include RSpec::Matchers

    # config.include FactoryGirl::Syntax::Methods

    # == Mock Framework
    config.mock_with :rspec

    # config.include Mongoid::Matchers

    # Clean up the database
    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner[:mongoid].strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.clean
    end    
  end
end