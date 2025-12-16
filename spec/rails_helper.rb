require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

# --- FIX START: FORCE BUNDLER LOAD FOR FACTORYBOT ---
# Explicitly loads all gems in the test group, ensuring FactoryBot is defined
# before the configuration block runs. This solves the persistent NameError.
Bundler.require(:default, Rails.env) 
# ---------------------------------------------------

require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories.
# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Ensures that the test database schema matches the current schema file.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end


RSpec.configure do |config|

  # Provides sign_in user helper for request specs
  config.include Devise::Test::IntegrationHelpers, type: :request
  # -----------------------------------
  
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]
  
  # Use transactions for speed, typical for Rails testing
  config.use_transactional_fixtures = true

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

require 'capybara/rails'
require 'selenium/webdriver'

# Register a headless Chrome driver
Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')        # Run without GUI
  options.add_argument('--disable-gpu')     # Needed in CI sometimes
  options.add_argument('--no-sandbox')      # Required for GitHub Actions
  options.add_argument('--window-size=1400,1400')
  options.add_argument('--disable-dev-shm-usage') # Avoid /dev/shm errors in CI

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Use headless_chrome for JavaScript tests
Capybara.javascript_driver = :headless_chrome