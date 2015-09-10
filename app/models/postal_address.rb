class PostalAddress < ActiveRecord::Base

  include BelongsToCreator
  include BelongsToUser

  has_many :orders

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

end
