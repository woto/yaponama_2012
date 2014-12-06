# encoding: utf-8
#
class SpareInfo < ActiveRecord::Base
  include Selectable

  include BrandAttributes
  include CachedBrand
  include SpareCatalogAttributes
  include CachedSpareCatalog

  has_many :from_spare_replacements, foreign_key: :from_spare_info_id, class_name: SpareReplacement, dependent: :destroy
  has_many :to_spare_replacements, foreign_key: :to_spare_info_id, class_name: SpareReplacement, dependent: :destroy
  has_many :spare_applicabilities, dependent: :destroy
  has_many :warehouses, dependent: :destroy

  (1..5).each do |n|
    mount_uploader "image#{n}", ApplicationUploader
  end

  (1..5).each do |n|
    mount_uploader "file#{n}", ApplicationUploader
  end

  has_one :accumulator, class_name: 'Opts::Accumulator', dependent: :destroy

  def to_label
    # TODO ранее тут был cached_brand. И в общем все работало, за исключением того, что допустим я создаю spare_info,
    # но валидация не проходит. А т.к. cached_brand заполняется в before_save (и до него доходит), то при выводе ошибки
    # через to_label cached_brand пустой. Как вариант можно изменить заполнение cached_brand с before_save на before_validation
    "#{catalog_number} (#{brand.to_label})"
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

  # TODO Написать для этого тест(?!)
  validate do
    if brand.try(:brand).present?
      errors[:base] << 'Нельзя указывать в качестве производителя синоним'
    end
  end

end
