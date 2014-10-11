# encoding: utf-8
#
class Brand < ActiveRecord::Base
  include Selectable
  include Transactionable
  include BelongsToCreator
  include CachedBrand
  include BrandAttributes

  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }

  has_many :brands, :inverse_of => :brand, :dependent => :destroy
  has_many :cars, :inverse_of => :brand
  has_many :models, :inverse_of => :brand, :dependent => :destroy

  has_many :spare_infos
  has_many :spare_applicabilities
  #has_many :spare_infos, through: :spare_applicabilities
  #has_many :for_cached_spare_infos, through: :spare_infos, class_name: "SpareApplicability", :source => :spare_applicabilities

  validate do
    if brand == self
      errors[:brand] << 'Нельзя указывать в качестве родительского производителя себя'
    end
  end

  has_many :products

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  before_validation :upcase_name

  def upcase_name
    self.name = name.upcase
  end

  after_save :update_all_cached_brand

  def update_all_cached_brand

    # TODO Переделать это как-нибудь более правильным способом.
    # Пока через ассоциацию почему-то не получилось
    # А это вообще возможно без сложного SQL запроса?
    spare_infos.each do |spare_info|
      spare_info.spare_applicabilities.update_all(cached_spare_info: "#{spare_info.catalog_number} (#{name})")
    end
    #for_cached_spare_infos.touch.update_all(cached_spare_info: "#{catalog_number} (#{name})")

    spare_applicabilities.update_all(cached_brand: name)
    products.update_all(cached_brand: name)
    cars.update_all(cached_brand: name)
    brands.update_all(cached_brand: name)
    spare_infos.update_all(cached_brand: name)
    models.update_all(cached_brand: name)
  end

end
