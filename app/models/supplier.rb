class Supplier < ActiveRecord::Base
  attr_accessible :name, :account_attributes
  has_one :account, :as => :accountable
  accepts_nested_attributes_for :account
  validates :account, :presence => true

  has_many :products

  def to_label
    name
  end

end
