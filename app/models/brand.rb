class Brand < ActiveRecord::Base
  include BelongsToCreator
  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }
  has_many :brands
  has_many :models, :dependent => :destroy
  belongs_to :brand
end
