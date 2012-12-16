class PostalAddress < ActiveRecord::Base
  include PingCallback
  has_many :orders

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  attr_accessible :city, :house, :notes, :postcode, :region, :room, :street, :company, :notes_invisible, :user_id, :human_confirmation_datetime, :visible
  #validates :user, :presence => true

  validates :city, :street, :house, :region, :postcode, :presence => true

  def to_label
    "#{company} - #{postcode} - #{region} - #{city} - #{street} - #{house} - #{room} - #{notes} - #{notes_invisible}"
  end
end
