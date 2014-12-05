require "open-uri"
require 'csv'

class DownloadWarehouse

  def self.download_warehouse
    Deliveries::Place.where.not(price_url: nil).each do |place|
      place.warehouses.delete_all
      open(place.price_url) do |f|
        CSV.parse(f.read) do |row|
          spare_info = SpareInfo.find_or_initialize_by(
            catalog_number: PriceMate.catalog_number(row[1]),
            brand: BrandMate.find_or_create_canonical!(row[3]),
          )
          spare_info.assign_attributes(:spare_catalog => PriceMate.spare_catalog) unless spare_info.spare_catalog
          puts row unless spare_info.save
          puts row unless place.warehouses.create(:spare_info => spare_info, :count => row[5], :price => row[6].to_i)
        end
      end
    end
  end

end
