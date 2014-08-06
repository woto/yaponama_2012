# encoding: utf-8
#
class SpareInfo < ActiveRecord::Base
  include Selectable
  include CachedBrand
  include CachedSpareCatalog
  include BrandAttributes
  include SpareCatalogAttributes

  has_many :spare_applicabilities

  def to_label
    "#{catalog_number} (#{cached_brand})"
  end

  def to_category_param
    "#{spare_catalog_id}-#{cached_spare_catalog.parameterize}"
  end

  validates :catalog_number, :presence => true, uniqueness:  { case_sensitive: false, :scope => :brand_id }

  #validates :catalog_number, presence: true

  before_save do
    self.name = "#{catalog_number} - #{cached_brand}"
    #self.cached_spare_catalog = SpareCatalog.find(spare_catalog_id).name
  end

  #scope :by_brand, ->(id) {
  #  joins(:spare_applicabilities).
  #  order(:cached_spare_catalog).
  #  where(spare_applicabilities: {brand_id: id.to_i, model_id: nil})
  #}

  scope :by_model, ->(id) {
    joins(:spare_applicabilities).
    #order(:cached_spare_catalog).
    where(spare_applicabilities: {model_id: id.to_i, generation_id: nil})
  }

  scope :by_generation, ->(id) {
    joins(:spare_applicabilities).
    #order(:cached_spare_catalog).
    where(spare_applicabilities: {generation_id: id.to_i, modification_id: nil})
  }

  scope :by_modification, ->(id) {
    joins(:spare_applicabilities).
    #order(:cached_spare_catalog).
    where(spare_applicabilities: {modification_id: id.to_i})
  }

  scope :by_category, ->(id) {
    #joins(:spare_applicabilities).
    where(spare_catalog_id: id.to_i)
  }

end
