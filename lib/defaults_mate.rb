class DefaultsMate
  # TODO Сюда же перенести значения по-умолчанию для категории
  # TODO задействовать!
  def self.brand
    BrandMate.find_or_create_canonical! nil
  end
end
