class SpareCatalogJob < ActiveJob::Base
  queue_as :default

  def perform(catalog_number_string, brand, spare_catalog)
    spare_catalog =  PriceMate.spare_catalog if spare_catalog.nil?
    if si = SpareInfo.find_by(catalog_number: catalog_number_string, brand: brand)
      si.update!(spare_catalog: spare_catalog)
    end
  end
end
