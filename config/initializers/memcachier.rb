if Rails.env.production?
  ENV["MEMCACHE_SERVERS"]  = ENV["MEMCACHIER_SERVERS"]
  ENV["MEMCACHE_USERNAME"] = ENV["MEMCACHIER_USERNAME"]
  ENV["MEMCACHE_PASSWORD"] = ENV["MEMCACHIER_PASSWORD"]
end