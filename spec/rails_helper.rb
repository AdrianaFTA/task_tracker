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
  # --- FACTORY BOT & DEVISE CONFIG ---
  # Allows you to use create(:user) instead of FactoryBot.create(:user)
  config.include FactoryBot::Syntax::Methods
  
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