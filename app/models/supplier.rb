class Supplier < ActiveRecord::Base
  attr_accessible :name, :account_attributes
  has_one :account, :as => :accountable
  accepts_nested_attributes_for :account

  has_many :products, :inverse_of => :supplier
end
