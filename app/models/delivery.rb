class Delivery < ActiveRecord::Base
  attr_accessible :available, :name, :notes, :notes_invisible, :sequence, :image
  attr_accessible :full_prepayment_required, :phone_required, :metro_required, :name_required, :postal_address_required, :delivery_cost_required, :delivery_category_id, :delivery_category
  has_many :orders
  belongs_to :delivery_category
  mount_uploader :image, DeliveryImageUploader

  validates :full_prepayment_required, :phone_required, :metro_required, :name_required, :postal_address_required, :delivery_cost_required, :inclusion => { :in => [true, false] }
  validates :available, :inclusion => { :in => [true, false] }
  validates :delivery_category_id, :presence => true

  def to_label
    delivery_category.to_label + " -> " + name
  end
end
