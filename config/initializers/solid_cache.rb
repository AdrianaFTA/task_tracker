# config/initializers/solid_cache.rb
SolidCache::Record.connects_to database: { writing: :production, reading: :production }