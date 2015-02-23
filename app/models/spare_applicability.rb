class SpareApplicability < ActiveRecord::Base

  include BrandAttributes
  include CachedBrand
  include ModelAttributes
  include CachedModel
  include GenerationAttributes
  include CachedGeneration
  include ModificationAttributes
  include CachedModification
  include SpareInfoAttributes
  include CachedSpareInfo

  validates :spare_info, presence: true
  validates :brand, presence: true
  validates :model, presence: true

  validates :spare_info, uniqueness: { scope: [:brand_id, :model_id, :generation_id, :modification_id] }

  def to_label
    "#{cached_spare_info} - #{cached_brand} - #{cached_model} - #{cached_generation} - #{cached_modification}"
  end

  def to_brand_param
    "#{brand_id}-#{cached_brand.parameterize}"
  end

  def to_model_param
    "#{model_id}-#{cached_model.parameterize}"
  end

  def to_generation_param
    "#{generation_id}-#{cached_generation.parameterize}"
  end

  def to_modification_param
    "#{modification_id}-#{cached_modification.parameterize}"
  end

  scope :by, ->{
    order(:cached_brand).
    select("spare_applicabilities.brand_id, spare_applicabilities.cached_brand, count(spare_applicabilities.id) as count").
    group("spare_applicabilities.brand_id, spare_applicabilities.cached_brand")
  }

  scope :by_brand, ->(id) {
    where(brand_id: id.to_i).
    order(:cached_model).
    where.not(model_id: nil).
    select("spare_applicabilities.model_id, spare_applicabilities.cached_model, spare_applicabilities.cached_brand, count(spare_applicabilities.id)").
    group("spare_applicabilities.model_id, spare_applicabilities.cached_model, spare_applicabilities.cached_brand")
  }

  scope :by_model, ->(id) {
    where(model_id: id.to_i).
    order(:cached_generation).
    where.not(generation_id: nil).
    select("spare_applicabilities.generation_id, spare_applicabilities.cached_generation, spare_applicabilities.cached_model, spare_applicabilities.cached_brand, count(spare_applicabilities.id)").
    group("spare_applicabilities.generation_id, spare_applicabilities.cached_generation, spare_applicabilities.cached_model, spare_applicabilities.cached_brand")
  }

  scope :by_generation, ->(id) {
    where(generation_id: id.to_i).
    order(:cached_modification).
    where.not(modification_id: nil).
    select("spare_applicabilities.modification_id, spare_applicabilities.cached_modification, spare_applicabilities.cached_generation, spare_applicabilities.cached_model, spare_applicabilities.cached_brand, count(spare_applicabilities.id)").
    group("spare_applicabilities.modification_id, spare_applicabilities.cached_modification, spare_applicabilities.cached_generation, spare_applicabilities.cached_model, spare_applicabilities.cached_brand")
  }

  scope :by_category, ->(id) {
    joins(:spare_info).
    where(spare_infos: {spare_catalog_id: id.to_i})
  }

  ## TODO Написать для этого тест(?!)
  #validate do
  #  if brand.try(:brand).present?
  #    errors[:base] << 'Нельзя указывать в качестве производителя синоним'
  #  end
  #end

end
