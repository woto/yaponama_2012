require "open-uri"
require 'csv'

class DownloadWarehouse

  def self.download_warehouse
    Warehouse.delete_all
    Deliveries::Place.where(active: true, display_marker: true).where(partner: false).each do |place|
      puts place.to_label
      open(place.price_url) do |f|
        CSV.parse(f.read) do |row|
          spare_info = SpareInfo.find_or_initialize_by(
            catalog_number: PriceMate.catalog_number(row[1]),
            brand: BrandMate.find_or_create_conglomerate(row[3]),
          )
          spare_info.assign_attributes(:spare_catalog => Defaults.spare_catalog) unless spare_info.spare_catalog

          unless spare_info.spare_info_phrase
            spare_info.spare_info_phrases.new(catalog_number: PriceMate.catalog_number(row[1]), primary: true)
          end

          unless spare_info.save
            puts row
            puts spare_info.errors.full_messages
          end

          unless place.warehouses.create(:spare_info => spare_info, :count => row[5], :price => row[6].to_i).persisted?
            puts row
            puts place.errors.full_messages
          end

        end
      end
    end
  end

end
