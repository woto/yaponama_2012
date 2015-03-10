class Defaults

  def self.spare_catalog
    SpareCatalog.find_or_create_by(name: 'Не разобранные')
  end

  def self.brand
    BrandMate.find_or_create_conglomerate nil
  end

end
