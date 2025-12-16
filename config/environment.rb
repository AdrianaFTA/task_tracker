# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.test?
  # This forces Bundler to require the gems in the test group,
  # ensuring FactoryBot is defined before RSpec tries to configure it.
  Bundler.require(*Rails.groups(
    assets: %w(development test),
    without: %w(production)
  ))
end

