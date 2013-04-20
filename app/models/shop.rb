class Shop < ActiveRecord::Base
  validates :name, :presence => true
  has_many :orders

  def to_label
    name
  end
end
