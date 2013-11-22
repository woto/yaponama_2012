# encoding: utf-8
#
class PostalAddress < ActiveRecord::Base
  include BelongsToSomebody
  include BelongsToCreator
  include Transactionable
  include Selectable

  has_many :orders

  has_many :companies_with_this_legal_address, :class_name => "Company", :foreign_key => "legal_address_id"
  has_many :companies_with_this_actual_address, :class_name  => "Company", :foreign_key => "actual_address_id"

  validates :city, :street, :house, :region, :presence => true
  validates :postcode, :presence => true, length: {is: 6}, :numericality => { :only_integer => true }

  validates :room, :presence => true, unless: Proc.new { |pa| pa.stand_alone_house }

  def to_label
    res = []
    res << postcode 
    res << region
    res << city
    res << street
    res << house
    res << room
    res.reject(&:blank?).join(', ')
  end

  include RenameMeConcern

  before_save :update_all_cached_postal_addresses

  def update_all_cached_postal_addresses
    companies_with_this_legal_address.update_all(cached_legal_address: self.to_label)
    companies_with_this_actual_address.update_all(cached_actual_address: self.to_label)
  end

end
