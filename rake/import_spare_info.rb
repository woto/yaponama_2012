require 'csv'

class ImportSpareInfo
  def self.import_spare_info args
    args.each do |i, url|
      begin
        open(url) do |f|
          f.each_line do |line|
            row = CSV.parse(line)[0]
            brand = BrandMate.find_or_create_canonical!(row[3])
            spare_catalog = PriceMate.spare_catalog
            catalog_number = PriceMate.catalog_number(row[1])
            s = SpareInfo.find_or_create_by(catalog_number: catalog_number, brand: brand, spare_catalog: spare_catalog)
            unless s.save
              puts "Не сохранили #{s.to_label}. #{s.errors.full_messages}"
            end
          end
        end
      rescue Exception => e
        puts "Ошибка соединения #{e.message}"
      end
    end
  end
end
