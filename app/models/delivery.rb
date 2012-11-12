class Delivery < ActiveRecord::Base
  attr_accessible :available, :name, :notes, :notes_invisible, :sequence, :image
  attr_accessible :full_prepayment_required, :phone_required, :name_required, :postal_address_required, :delivery_cost_required, :delivery_category_id
  has_many :orders, :inverse_of => :delivery
  belongs_to :delivery_category
  mount_uploader :image, DeliveryImageUploader
end
