class SpareCatalog < ActiveRecord::Base

  belongs_to :spare_catalog_group
  has_and_belongs_to_many :brands
  # TODO При удалении выставлять значение по-умолчанию
  # у связанных spare_infos
  has_many :spare_infos
  #has_many :spare_applicabilities, through: :spare_infos
  has_many :spare_catalog_tokens, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :name, length: {maximum: 50}

  accepts_nested_attributes_for :spare_catalog_tokens, allow_destroy: true

  #before_validation do
  #  self.name = name.mb_chars.upcase
  #end

  # Когда редактируется категория, и прилетает пустой opt (выбор принадлежности к какой-нибудь
  # особой категории, напр. accumulator), то поле nil перезаписывается на "". Это нежелательное
  # поведение. Так же как вариант можено было бы в коде применять не @spare_catalog.opt, а @spare_catalog.opt?
  # но остановился на сбросе в nil.
  before_save do
    self.opt = nil if opt.blank?
  end

  # Если имя изменили, то фактически это становится новая/другая категория, поэтому количество звпросов 
  # в месяц по Яндексу необходимо сбросить.
  before_save do
    if name_was != name
      self.shows = nil
    end
  end

  before_destroy do
    spare_catalog = Defaults.spare_catalog
    if spare_infos.exists?
      spare_infos.each do |si|
        si.update(spare_catalog: spare_catalog)
      end
    end
  end

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  after_save :rebuild

  def rebuild
    # Сделано по образу brand
    if changes[:name]
      clear_changes_information
      spare_infos.each {|spare_info| spare_info.save}
    end
  end

end
