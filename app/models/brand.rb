class Brand < ActiveRecord::Base
  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }
  has_many :brands
  has_many :models, :class_name => "Admin::Model", :dependent => :destroy
  belongs_to :brand
end
