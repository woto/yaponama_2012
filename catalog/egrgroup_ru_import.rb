require 'csv'

class EgrgroupRuImport
    def self.egrgroup_ru_import
      path = File.join(Rails.root, 'catalog', 'egrgroup_ru.csv')
      CSV.foreach(path) do |row|

        catalog_number = PriceMate.catalog_number(row[1])
        brand = row[3]
        model = row[4]
        generation = row[2]
        manufacturer = row[5]

        if catalog_number.present? && manufacturer.present? && brand.present? && model.present? && generation.present?

          brand = BrandMate.find_or_create_canonical!(brand)
          model = Model.find_or_create_by!(name: model, brand: brand)
          generation = Generation.find_or_create_by!(name: generation, model: model)

          manufacturer = BrandMate.find_or_create_canonical!(manufacturer)
          spare_info = SpareInfo.find_or_initialize_by(catalog_number: catalog_number, brand: manufacturer)
          spare_info.spare_catalog = PriceMate.spare_catalog
          unless spare_info.save
            binding.pry
          end

          SpareApplicability.find_or_create_by!(spare_info: spare_info, brand: brand, model: model, generation: generation)
        else
          puts "skip #{row}"
        end
      end
    end
end
