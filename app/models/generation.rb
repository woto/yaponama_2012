class Generation < ActiveRecord::Base
  belongs_to :model
  has_many :modifications, :dependent => :destroy

  def to_label
    "#{model.to_label} -> #{name}"
  end

end
