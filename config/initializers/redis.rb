$redis = Redis.new(:host => ::CONFIG.redis['host'], :port => ::CONFIG.redis['port'])
