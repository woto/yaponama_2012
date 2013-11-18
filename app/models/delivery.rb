# encoding: utf-8
#
class Delivery < ActiveRecord::Base
  has_many :orders
  mount_uploader :image, DeliveryImageUploader

  validates :available, :inclusion => { :in => [true, false] }

  validates :name, :presence => true

  def to_label
    name
  end
end
