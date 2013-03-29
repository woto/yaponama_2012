module ConfigHelper

  extend ActiveSupport::Concern

  def socket_io_full_address
    "#{socket_io_address}#{socket_io_port.present? ? ":" + socket_io_port : ''}"
  end

  def juggernaut_full_address
    "#{juggernaut_address}#{juggernaut_port.present? ? ":" + juggernaut_port : ''}"
  end

  def site_full_address
    "#{site_address}#{site_port.present? ? ":" + site_port : ''}"
  end

  def redis_full_address
    "#{redis_address}#{redis_port.present? ? ":" + redis_port : ''}"
  end

  def price_full_address
    "#{price_address}#{price_port.present? ? ":" + price_port : ''}"
  end

  def get_image_data_full_address
    "#{get_image_data_address}#{get_image_data_port.present? ? ":" + get_image_data_port : ''}"
  end

  def default_user_attributes
    {
      'prepayment' => default_user_prepayment,
      'discount' => default_user_discount,
      'order_rule' => default_user_order_rule,
      'role' => Rails.configuration.default_user_role
    }
  end

end
