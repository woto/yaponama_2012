class Somebody < ActiveRecord::Base
  has_many :phones
  has_many :emails
  has_many :cars
  has_many :profiles
  has_one :account
  has_many :names
  has_many :postal_addresses
  has_many :orders
  has_many :products
end 
