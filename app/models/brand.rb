class Brand < ActiveRecord::Base
  include Selectable
  include Transactionable
  include BelongsToCreator
  include CachedBrand
  include BrandAttributes

  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }

  has_many :brands, :inverse_of => :brand
  has_many :cars, :inverse_of => :brand
  has_many :models, :inverse_of => :brand, :dependent => :destroy

  has_many :spare_infos
  has_many :products

  def to_label
    name
  end
  
  after_save :update_all_cached_brand

  def update_all_cached_brand
    products.update_all(cached_brand: name)
    cars.update_all(cached_brand: name)
    brands.update_all(cached_brand: name)
    spare_infos.update_all(cached_brand: name)
    models.update_all(cached_brand: name)
  end

end
