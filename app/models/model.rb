class Model < ActiveRecord::Base
  belongs_to :brand
  has_many :generations, :dependent => :destroy

  def to_label
    "#{brand.to_label} -> #{name}"
  end

end
