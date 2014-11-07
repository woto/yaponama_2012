class SpareCatalog < ActiveRecord::Base

  has_many :spare_infos
  has_many :spare_applicabilities, through: :spare_infos

  validates :name, presence: true, uniqueness: true

  before_save do
    name = self.name.mb_chars
    content = self.content.to_s.mb_chars

    name = name.upcase
    content = content.upcase

    #name = name.gsub('Ё', 'Е')
    content = content.gsub('Ё', 'Е')

    content = content.gsub(/[^[:word:]\s]/, ' ')

    self.content = content
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
