class Model < ActiveRecord::Base
  has_paper_trail
  belongs_to :brand
  has_many :generations, :dependent => :destroy

  def to_label
    "#{brand.to_label} -> #{name}"
  end

end
