class Metro < ActiveRecord::Base

  validates :metro, :presence => true
  validates :delivery_cost, :numericality => {:only_integer => true}

  has_many :orders

  def to_label
    metro
  end

end
