require 'csv'

class UpdateSpareCatalog
  def self.update_spare_catalog
    spare_catalog = PriceMate.spare_catalog
    SpareInfo.where(spare_catalog: spare_catalog).order("RANDOM()").find_each do |spare_info|
      catalog_number = spare_info.catalog_number
      puts "Поиск #{catalog_number}"
      begin
        open("http://#{Rails.configuration.site['host']}:#{Rails.configuration.site['port']}/user/products/new?catalog_number=#{PriceMate.catalog_number(catalog_number)}")
      rescue OpenURI::HTTPError => e
        puts "Не найден: #{catalog_number}"
      end
      sleep 5
    end
  end
end
