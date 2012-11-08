class DeliveryCategory < ActiveRecord::Base
  attr_accessible :name, :notes, :notes_invisible, :image
  mount_uploader :image, DeliveryCategoryImageUploader
  has_many :deliveries

  def to_label
    name
  end
end
