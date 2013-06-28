ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'support/deffered_garbage_collection'

class ActiveSupport::TestCase

  include FactoryGirl::Syntax::Methods
  include Warden::Test::Helpers
  Warden.test_mode!

  DatabaseCleaner.strategy = :truncation

  setup do
    FactoryGirl.reload
    DatabaseCleaner.start
    GC.disable
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
    Warden.test_reset!
    GC.enable
  end
end

class ActionDispatch::IntegrationTest

  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Selenium should not use fixtures
  self.use_transactional_fixtures = false
end
