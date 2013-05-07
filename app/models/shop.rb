class Shop < ActiveRecord::Base
  validates :name, :presence => true
  has_many :orders

  belongs_to :delivery

  def to_label
    name
  end
end
