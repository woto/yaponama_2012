class User < ActiveRecord::Base
  include PingCallback
  attr_accessible :name, :invisible, :phones_attributes, :email_addresses_attributes, :postal_addresses_attributes, :cars_attributes, :names_attributes, :requests_attributes, :products_attributes, :time_zone_id, :human_confirmation_datetime, :orders_attributes
  has_many :email_addresses, :dependent => :destroy, :inverse_of => :user
  has_many :phones, :dependent => :destroy, :inverse_of => :user
  has_many :postal_addresses, :dependent => :destroy, :inverse_of => :user
  has_many :cars, :dependent => :destroy, :inverse_of => :user
  has_many :names, :dependent => :destroy, :inverse_of => :user
  has_many :requests, :dependent => :destroy, :inverse_of => :user
  has_many :products, :dependent => :destroy, :inverse_of => :user
  has_many :orders, :dependent => :destroy, :inverse_of => :user
  accepts_nested_attributes_for :phones, :postal_addresses, :email_addresses, :cars, :names, :requests, :products, :orders, :allow_destroy => true
  belongs_to :time_zone
  has_one :ping, :dependent => :destroy, :inverse_of => :user

  def to_label
    "#{id} - #{names.collect{|name| name.name}.join(', ')}"
  end

end
