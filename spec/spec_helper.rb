# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
# automatically update test DB against current schema
ActiveRecord::Migration.maintain_test_schema!
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rspec'
Capybara.javascript_driver = :webkit
Capybara.run_server = true
Capybara.default_wait_time = 5
Capybara.server_port = 6543
Capybara.app_host = "http://localhost:#{Capybara.server_port}"

require 'webmock/rspec'
require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = {
    re_record_interval: 1.week
  }
end
WebMock.disable!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.before(:each) { Rails.cache.clear }

  config.include ActiveSupport::Testing::TimeHelpers
end
