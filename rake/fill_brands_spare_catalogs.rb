class FillBrandsSpareCatalogs
  def self.fill_brands_spare_catalogs
    BrandsSpareCatalogs.delete_all
    SpareCatalog.all.each do |spare_catalog|
      spare_catalog.spare_infos.joins(:spare_applicabilities, :brand).group("brands.id").pluck("brands.id").each do |brand_id|
        spare_catalog.brands << Brand.find(brand_id)
      end
    end
  end
end
