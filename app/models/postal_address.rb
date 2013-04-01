class PostalAddress < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator
  include Transactionable
  has_many :orders

  validates :city, :street, :house, :region, :presence => true
  validates :postcode, :presence => true, length: {is: 6}

  def to_label
    "#{postcode} - #{region} - #{city} - #{street} - #{house} - #{room} - #{notes} - #{notes_invisible}"
  end
end
