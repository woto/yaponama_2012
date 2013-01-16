class Brand < ActiveRecord::Base
  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }
  has_many :brands
  belongs_to :brand
end
