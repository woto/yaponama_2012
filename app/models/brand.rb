class Brand < ActiveRecord::Base
  has_paper_trail

  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }
  has_many :brands
  has_many :models, :dependent => :destroy
  belongs_to :brand

  def to_label
    name
  end

end
