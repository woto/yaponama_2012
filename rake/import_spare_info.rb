require 'open-uri'
require 'csv'

class ImportSpareInfo
  LOGGER = Logger.new(STDOUT)

  def self.import_spare_info args
    args.each do |i, url|
      LOGGER.info 'Starting download'
      open(url) do |f|
        LOGGER.info 'Download finished'
        f.each_line do |line|
          begin
            row = CSV.parse(line)[0]
            result = PriceMate.search(row[1], nil, false, false, true)
            size = result['result_prices'].select{|item| item['success_percent'] > 0 && item['count'].to_i >= 2 && item['retail_cost'] > 300 && item['delivery_days_declared'].to_i < 5}.size
            if size >= 5
              LOGGER.info "Positive #{row}"
              spare_info = SpareInfo.find_or_initialize_by(
                catalog_number: PriceMate.catalog_number(row[1]),
                brand: BrandMate.find_or_create_conglomerate(row[3])
              )
              spare_info.assign_attributes(spare_catalog: Defaults.spare_catalog) unless spare_info.spare_catalog
              unless spare_info.save
                LOGGER.warn "Не сохранили #{spare_info.to_label}. #{spare_info.errors.full_messages}"
              end
            end
          rescue ActiveRecord::RecordInvalid => e
            LOGGER.warn e.message
          rescue Exception => e
            LOGGER.warn "Ошибка #{e.message}"
          end
        end
      end
    end
  end
end
