class Brand < ActiveRecord::Base
  attr_accessible :brand_id, :content, :image, :name, :rating
  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }
  has_many :brands
  belongs_to :brand
end
