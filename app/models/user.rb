class User < ActiveRecord::Base

  has_many :products, :dependent => :destroy, :inverse_of => :user

  has_many :products_incart, :dependent => :destroy, :inverse_of => :user, :conditions => {:status => :incart}, :class_name => "Product"
  attr_accessible :products_incart_attributes
  accepts_nested_attributes_for :products_incart, :allow_destroy => true

  include PingCallback
  attr_accessible :name, :invisible, :phones_attributes, :email_addresses_attributes, :postal_addresses_attributes, :cars_attributes, :names_attributes, :requests_attributes, :time_zone_id, :human_confirmation_datetime, :orders_attributes, :money_available, :money_locked, :discount
  has_many :email_addresses, :dependent => :destroy, :inverse_of => :user
  has_many :phones, :dependent => :destroy, :inverse_of => :user
  has_many :postal_addresses, :dependent => :destroy, :inverse_of => :user
  has_many :cars, :dependent => :destroy, :inverse_of => :user
  has_many :names, :dependent => :destroy, :inverse_of => :user
  has_many :requests, :dependent => :destroy, :inverse_of => :user
  has_many :orders, :dependent => :destroy, :inverse_of => :user
  accepts_nested_attributes_for :phones, :postal_addresses, :email_addresses, :cars, :names, :requests, :orders, :allow_destroy => true
  belongs_to :time_zone
  has_one :ping, :dependent => :destroy, :inverse_of => :user

  # Financial
  attr_accessible :account_attributes
  has_one :account, :as => :accountable
  accepts_nested_attributes_for :account

  def to_label
    "#{id} - #{names.collect{|name| name.name}.join(', ')}"
  end

end
