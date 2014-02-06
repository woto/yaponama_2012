# encoding: utf-8
#
class Delivery < ActiveRecord::Base

  #accepts_nested_attributes_for :postal_address
  #def postal_address_attributes=(attr)
  #  if attr['id']
  #    self.postal_address = PostalAddress.find attr["id"]
  #    self.postal_address.assign_attributes attr
  #  else
  #    super
  #  end
  #end

  #has_many :orders
  #mount_uploader :image, DeliveryImageUploader

  #validates :available, :inclusion => { :in => [true, false] }

  #validates :name, :presence => true

  #def to_label
  #  name
  #end
end
