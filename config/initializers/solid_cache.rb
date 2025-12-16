# config/initializers/solid_cache.rb
SolidCache.connects_to database: { writing: :production, reading: :production }