class PostalAddress < ActiveRecord::Base
  belongs_to :user, :inverse_of => :postal_addresses
  attr_accessible :city, :house, :notes, :postcode, :region, :room, :street, :company, :invisible, :user_id, :human_confirmation_datetime
  validates :postcode, :city, :street, :presence => true
  validates :house, :presence => true
  validates :user, :presence => true
end
