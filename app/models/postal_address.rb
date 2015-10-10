class PostalAddress < ActiveRecord::Base

  include BelongsToCreator
  include BelongsToUser

  has_many :orders

  validates :street, :house, :presence => true
  validates :room, :presence => true, unless: ->(pa) {pa.stand_alone_house}
  with_options unless: ->(pa) {pa.is_moscow} do
    validates :city, :region, :presence => true
    validates :postcode, :presence => true, length: {is: 6}, :numericality => { :only_integer => true }
  end

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

end
