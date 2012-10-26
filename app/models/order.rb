class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  include PingCallback
  belongs_to :user, :inverse_of => :orders
  belongs_to :name, :inverse_of => :orders
  belongs_to :postal_address, :inverse_of => :orders
  has_many :products, :dependent => :destroy, :inverse_of => :order
  attr_accessible :products_attributes, :name_id, :postal_address_id
  accepts_nested_attributes_for :products, :allow_destroy => true

  def to_label
    "#{name_id} - #{postal_address_id} - #{user_id} - #{product_id} - #{created_at} - #{updated_at}"
  end

end
