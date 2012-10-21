class PostalAddress < ActiveRecord::Base
  include PingCallback
  belongs_to :user, :inverse_of => :postal_addresses
  attr_accessible :city, :house, :notes, :postcode, :region, :room, :street, :company, :invisible, :user_id, :human_confirmation_datetime
  validates :user, :presence => true
end
