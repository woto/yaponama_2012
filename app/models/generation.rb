class Generation < ActiveRecord::Base
  belongs_to :model
  has_many :modifications, :dependent => :destroy

  validates :model, :name, :presence => true

  def to_label
    "#{model.to_label} -> #{name}"
  end

end
