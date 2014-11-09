class SpareCatalog < ActiveRecord::Base

  has_many :spare_infos
  #has_many :spare_applicabilities, through: :spare_infos
  has_many :spare_catalog_tokens, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :spare_catalog_tokens, allow_destroy: true

  before_save do
    name = self.name.mb_chars
    name = name.upcase
    self.name = name
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
