# This file is used by Rack-based servers to start the application.
require 'faye'
require ::File.expand_path('../config/environment',  __FILE__)

bayeux = Faye::RackAdapter.new(
  Rails.application,
  :mount => '/faye',
  :timeout => 25,
  :engine  => {
    :type  => Faye::Redis,
    :host  => SiteConfig.redis_address,
    :port  => SiteConfig.redis_port
  }
)

run bayeux
