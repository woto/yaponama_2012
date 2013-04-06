$redis = Redis.new(:host => ::SiteConfig.redis_address, :port => ::SiteConfig.redis_port)
