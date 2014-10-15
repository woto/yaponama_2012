$redis = Redis.new(:host => ::Rails.application.config_for('application/redis')['host'], :port => ::Rails.application.config_for('application/redis')['port'])
