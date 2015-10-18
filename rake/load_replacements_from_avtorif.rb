require 'open-uri'
require 'csv'

class LoadReplacementsFromAvtorif
  LOGGER = Logger.new(STDOUT)

  def self.load_replacements_from_avtorif
    CSV.foreach("#{Rails.root}/result.csv") do |row|
      LOGGER.info row
      if row.all?{|column| column.present?}
        from_spare_info = SpareInfo.find_or_initialize_by(
          catalog_number: PriceMate.catalog_number(row[0]),
          brand: BrandMate.find_conglomerate(row[1])
        )
        to_spare_info = SpareInfo.find_or_initialize_by(
          catalog_number: PriceMate.catalog_number(row[2]),
          brand: BrandMate.find_conglomerate(row[3])
        )
        if from_spare_info.new_record?
          from_spare_info.spare_catalog = Defaults.spare_catalog
          from_spare_info.spare_info_phrases.new(catalog_number: from_spare_info.catalog_number, primary: true)
        end
        if to_spare_info.new_record?
          to_spare_info.spare_catalog = Defaults.spare_catalog
          to_spare_info.spare_info_phrases.new(catalog_number: to_spare_info.catalog_number, primary: true)
        end
        if from_spare_info.persisted? || to_spare_info.persisted?
          unless sr = SpareReplacement.create(from_spare_info: from_spare_info, to_spare_info: to_spare_info, status: :repl_num, wrong: false)
            binding.pry
          end
        end
      end
    end
  end
end
