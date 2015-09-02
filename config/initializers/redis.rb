$redis = Redis.new(:host => ::Rails.configuration.redis['host'], :port => ::Rails.configuration.redis['port'])
