class SpareInfo < ActiveRecord::Base

  concerning :SpareCatalogConcern do
    included do
      belongs_to :spare_catalog
      accepts_nested_attributes_for :spare_catalog
      validates :spare_catalog, :presence => true
    end

    def spare_catalog_attributes=(attr)
      if attr["name"].present?
        spare_catalog = ::SpareCatalog.where(name: attr["name"]).first
        if spare_catalog.present?
          self.spare_catalog = spare_catalog
        else
          self.spare_catalog = ::SpareCatalog.new(name: attr["name"])
        end
      else
        self.spare_catalog = ::SpareCatalog.new
      end
    end
  end

  concerning :BrandConcern do
    included do
      belongs_to :brand
      accepts_nested_attributes_for :brand
      validates :brand, presence: true
    end
    def brand_attributes=(attr)
      if attr["name"].present?
        brand = ::Brand.where(name: attr["name"]).first
        if brand.present?
          self.brand = brand
        else
          self.brand = ::Brand.new(name: attr["name"])
        end
      else
        self.brand = ::Brand.new
      end
    end
  end

  ransacker :titles_as_string do
    Arel.sql("array_to_string(titles, '|')")
  end

  has_many :warehouses, dependent: :restrict_with_error
  has_many :places, :through => :warehouses

  has_many :spare_info_phrases, dependent: :destroy
  validates :spare_info_phrases, presence: true
  accepts_nested_attributes_for :spare_info_phrases, allow_destroy: true

  #before_validation on: :create do
  #  unless spare_info_phrase
  #    spare_info_phrases.new(catalog_number: catalog_number, primary: true)
  #  end
  #end

  validate do
    errors.add(:base, 'Должна существовать хотя бы одна фраза и она должна быть отмечена как главная.') if !spare_info_phrases.one?(&:primary)
  end

  has_one :spare_info_phrase, -> { where(primary: true) }

  has_many :from_spare_replacements, foreign_key: :from_spare_info_id, class_name: SpareReplacement, dependent: :restrict_with_error
  has_many :to_spare_replacements, foreign_key: :to_spare_info_id, class_name: SpareReplacement, dependent: :restrict_with_error
  has_many :spare_applicabilities, dependent: :restrict_with_error

  before_destroy :check_attributes

  def check_attributes
    (1..8).each do |n|
      if self.send("image#{n}").present?
        errors.add(:base, "Невозможно удалить SpareInfo, т.к. у него заполнен image#{n}")
        return false
      end
    end
    (1..8).each do |n|
      if self.send("file#{n}").present?
        errors.add(:base, "Невозможно удалить SpareInfo, т.к. у него заполнен file#{n}")
        return false
      end
    end
    if content.present?
      errors.add(:base, "Невозможно удалить SpareInfo, т.к. у него заполнен content")
      return false
    end
    if hstore.present?
      errors.add(:base, "Невозможно удалить SpareInfo, т.к. у него заполнен hstore")
      return false
    end
  end

  (1..8).each do |n|
    mount_uploader "image#{n}", ApplicationUploader
  end

  (1..8).each do |n|
    mount_uploader "file#{n}", ApplicationUploader
  end

  has_one :accumulator, class_name: 'Opts::Accumulator', dependent: :restrict_with_error
  has_one :truck_tire, class_name: 'Opts::TruckTire', dependent: :restrict_with_error

  def to_label
    "#{catalog_number} (#{brand.to_label})"
  end

  validates :catalog_number, :presence => true, uniqueness:  { case_sensitive: false, :scope => :brand_id }


  before_save do
    self.name = to_label
  end


  # Используется в ручной/автоматической смене категории
  attr_accessor :change_spare_catalog

  before_save do
    if change_spare_catalog || !fix_spare_catalog
    else
      restore_attributes [:spare_catalog_id]
    end
  end

  scope :by_brand, ->(id) {
    joins(:spare_applicabilities).
    where(spare_applicabilities: {brand_id: id.to_i}).
    distinct
  }

  scope :by_model, ->(id) {
    joins(:spare_applicabilities).
    where(spare_applicabilities: {model_id: id.to_i}).
    distinct
  }

  scope :by_generation, ->(id) {
    joins(:spare_applicabilities).
    where(spare_applicabilities: {generation_id: id.to_i}).
    distinct
  }

  scope :by_modification, ->(id) {
    joins(:spare_applicabilities).
    where(spare_applicabilities: {modification_id: id.to_i}).
    distinct
  }

  scope :by_category, ->(id) {
    includes(:spare_catalog).
    order("spare_catalogs.name").
    where(spare_catalog_id: id.to_i).
    distinct
  }

  validate do
    if brand.try(:sign)
      errors[:brand] << 'Нельзя указывать производителя, у которого есть родитель.'
    end
  end

end
