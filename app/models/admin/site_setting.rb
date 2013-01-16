class Admin::SiteSetting < ActiveRecord::Base

  def self.current_environment
    where(:environment => Rails.env).first
  end

  def socket_io_full_address
    socket_io_address + ":" + socket_io_port
  end

  def juggernaut_full_address
    juggernaut_address + ":" + juggernaut_port
  end

  def site_full_address
    site_address + ":" + site_port
  end

  def redis_full_address
    redis_address + ":" + redis_port
  end

  def price_full_address
    price_address + ":" + price_port
  end

end
