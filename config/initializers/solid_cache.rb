# config/initializers/solid_cache.rb

Rails.application.reloader.to_prepare do
  # 1. Ensure SolidCache::Record is loaded
  unless defined?(SolidCache) && defined?(SolidCache::Record)
    require "solid_cache"
  end

  # 2. Fetch the production configuration directly
  production_config = Rails.application.config_for(:database, env: "production")

  # 3. Alias the required :cache database connection to :production
  Rails.application.config.active_record.database_configuration["cache"] = production_config

  # 4. Connect the Solid Cache models to the 'cache' database configuration
  SolidCache::Record.connects_to database: { writing: :cache, reading: :cache }
end