class PostalAddress < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator
  has_many :orders

  validates :city, :street, :house, :region, :postcode, :presence => true

  def to_label
    "#{company} - #{postcode} - #{region} - #{city} - #{street} - #{house} - #{room} - #{notes} - #{notes_invisible}"
  end
end
