require "open-uri"
require 'csv'

class DownloadWarehouse

  def self.download_warehouse
    Deliveries::Place.where(active: true).each do |place|
      place.warehouses.delete_all
      open(place.price_url) do |f|
        CSV.parse(f.read) do |row|
          spare_info = SpareInfo.find_or_initialize_by(
            catalog_number: PriceMate.catalog_number(row[1]),
            brand: BrandMate.find_or_create_conglomerate(row[3]),
          )
          spare_info.assign_attributes(:spare_catalog => Defaults.spare_catalog) unless spare_info.spare_catalog
          puts row unless spare_info.save
          puts row unless place.warehouses.create(:spare_info => spare_info, :count => row[5], :price => row[6].to_i).persisted?
        end
      end
    end
  end

end
