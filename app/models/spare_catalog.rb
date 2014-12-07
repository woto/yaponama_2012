class SpareCatalog < ActiveRecord::Base

  has_many :spare_infos
  #has_many :spare_applicabilities, through: :spare_infos
  has_many :spare_catalog_tokens, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :spare_catalog_tokens, allow_destroy: true

  before_validation do
    self.name = name.mb_chars.upcase
  end

  before_destroy do
    spare_catalog = PriceMate.spare_catalog
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
