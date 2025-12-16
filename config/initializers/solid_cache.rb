# config/initializers/solid_cache.rb
# This ensures that SolidCache::Record is loaded before we attempt to configure it.
ActiveSupport.on_load(:active_record) do
  # Note: We must ensure SolidCache is defined before calling connects_to
  unless defined?(SolidCache) && defined?(SolidCache::Record)
    require "solid_cache"
  end

  Rails.application.config.active_record.database_configuration["cache"] = 
    Rails.application.config.active_record.database_configuration["production"]

  # Connect the Solid Cache models to the primary production database connection
  SolidCache::Record.connects_to database: { writing: :production, reading: :production }
end