class Delivery < ActiveRecord::Base
  has_many :orders
  belongs_to :delivery_category
  mount_uploader :image, DeliveryImageUploader

  validates :full_prepayment_required, :phone_required, :metro_required, :shop_required, :name_required, :postal_address_required, :delivery_cost_required, :inclusion => { :in => [true, false] }
  validates :available, :inclusion => { :in => [true, false] }
  validates :delivery_category_id, :presence => true

  validates :name, :presence => true

  def to_label
    delivery_category.to_label + " -> " + name
  end
end
