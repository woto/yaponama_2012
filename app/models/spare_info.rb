# encoding: utf-8
#
class SpareInfo < ActiveRecord::Base
  include Selectable

  include BrandAttributes
  include CachedBrand
  include SpareCatalogAttributes
  include CachedSpareCatalog

  has_many :from_spare_replacements, foreign_key: :from_spare_info_id, class_name: SpareReplacement
  has_many :to_spare_replacements, foreign_key: :to_spare_info_id, class_name: SpareReplacement
  has_many :spare_applicabilities

  def to_label
    "#{catalog_number} (#{cached_brand})"
  end

  def to_category_param
    "#{spare_catalog_id}-#{cached_spare_catalog.parameterize}"
  end

  validates :catalog_number, :presence => true, uniqueness:  { case_sensitive: false, :scope => :brand_id }

  validates :spare_catalog, :presence => true

  before_save do
    self.name = to_label
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

  after_update :rebuild

  def rebuild

    # Делать это нужно только если изменились данные, влияющие на формирование
    # cached_spare_info (каталожник, производитель) - spare_info#to_label
    # В противном случае при изменении SpareCatalog тут будет много лишних обновлений
    # Категория изменилась, потянула за собой изменение cached_spare_catalog у всех
    # зависимых spare_infos, а эти spare_infos еще потянут замены и применимость

    if changes[:name] #changes[:catalog_number] || changes[:cached_brand]

      # По образу brand
      clear_changes_information

      # Обновляем cached_spare_info замены
      from_spare_replacements.each do |replacement|
        replacement.save
      end

      to_spare_replacements.each do |replacement|
        replacement.save
      end
      # /Обновляем cached_spare_info замены

      # Обновляем cached_spare_info применимость
      spare_applicabilities.each do |spare_applicability|
        spare_applicability.save
      end
      # /Обновляем cached_spare_info применимость

    end

  end

end
