class DeliveryCategory < ActiveRecord::Base
  mount_uploader :image, DeliveryCategoryImageUploader
  has_many :deliveries

  def to_label
    name
  end
end
