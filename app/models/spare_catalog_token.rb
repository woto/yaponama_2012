class SpareCatalogToken < ActiveRecord::Base
  belongs_to :spare_catalog

  before_validation do
    self.name = name.mb_chars.upcase
    self.subtract = subtract.mb_chars.upcase
  end

  # В методе соотношения к категории мы проверяем на nil, если утвердительно,
  # то пропускаем вычитаемые ключевые слова, иначе используем)
  before_save do
    self.subtract = nil if subtract.blank?
  end
end
