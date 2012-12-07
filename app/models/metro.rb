class Metro < ActiveRecord::Base

  attr_accessible :metro, :delivery_cost

  validates :metro, :presence => true
  validates :delivery_cost, :numericality => {:only_integer => true}

  has_many :orders

  def to_label
    metro
  end

end
