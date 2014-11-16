require 'csv'

class FebestComUaImport
  class << self
    def febest_com_ua_import

      manufacturer_fr = BrandMate.find_or_create_canonical('FEBEST')

      path = File.join(Rails.root, "catalog", "febest_com_ua.csv")
      CSV.foreach(path) do |row|

        catalog_number_fr = PriceMate.catalog_number(row[0])
        catalog_number_to = PriceMate.catalog_number(row[7])
        manufacturer_to = BrandMate.find_or_create_canonical!(row[6])
        model = row[3]#.to_s.match(/\b(.+?)\b/)[0]
        generation = row[4]

        if catalog_number_fr.present? && catalog_number_to.present? && manufacturer_to.present? && model.present? && generation.present?

          model = manufacturer_to.models.find_or_create_by!(name: model)
          generation = model.generations.find_or_create_by!(name: generation)

          fr = SpareInfo.find_or_initialize_by(:catalog_number => catalog_number_fr, :brand => manufacturer_fr)
          fr.spare_catalog = PriceMate.spare_catalog
          unless fr.save
            binding.pry
          end

          to = SpareInfo.find_or_initialize_by(:catalog_number => catalog_number_to, :brand => manufacturer_to)
          to.spare_catalog = PriceMate.spare_catalog
          unless to.save
            binding.pry
          end

          sr = SpareReplacement.find_or_initialize_by(from_spare_info: fr, to_spare_info: to)
          unless sr.save
            binding.pry
          end

          sa = SpareApplicability.find_or_initialize_by(spare_info: fr, brand: manufacturer_to, model: model, generation: generation)
          unless sa.save
            binding.pry
          end

          sa = SpareApplicability.find_or_initialize_by(spare_info: to, brand: manufacturer_to, model: model, generation: generation)
          unless sa.save
            binding.pry
          end

        else
          puts "skip #{row}"
        end

      end
    end
  end
end
