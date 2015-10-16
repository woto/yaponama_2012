class User < ActiveRecord::Base

  include Concerns::Models::Bot
  include Concerns::Models::Authentication
  include Concerns::Models::Authorization
  include BelongsToCreator

  before_validation do
    self.phone = '' if phone == '+7 (___) ___-__-__'
  end

  with_options dependent: :destroy do
    has_many :cars
    has_many :products
    has_many :postal_addresses
    has_many :orders
  end

  def to_label
    [name, phone, email].reject{|value| value.blank?}.join(', ').presence ||
      "#{id.to_s.scan(/.{3}|.+/).join("-")} #{created_at.utc.strftime("%d-%m-%y")}"
  end

end
