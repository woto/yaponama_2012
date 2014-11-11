require 'csv'

class FebestComUaImport
  class << self
  def febest_com_ua_import
    febest = BrandMate.find_or_create_canonical('FEBEST')
    path = File.join(Rails.root, "catalog", "febest_com_ua.csv")
    CSV.foreach(path) do |row|
      if row[0].present? && row[1].present? && row[3].present? && row[7].present?

          f = PriceMate.search row[0], 'FEBEST', false, false, false

          if f["result_prices"].present?

            puts "found #{row}"
            brand = BrandMate.find_or_create_canonical!(row[6])
            fr = SpareInfo.find_or_initialize_by(:catalog_number => row[0].gsub(/[^a-z0-9]/i, ''), :brand => febest)
            fr.assign_attributes(
              :spare_catalog => PriceMate.guess_spare_catalog(row[0], febest.name, false, false, false),
              :content => row[1]
            )
            begin
              fr.save!
            rescue
              binding.pry
            end
            to = SpareInfo.find_or_initialize_by(:catalog_number => row[7].gsub(/[^a-z0-9]/i, ''), :brand => brand)
            to.assign_attributes(
              :spare_catalog => PriceMate.guess_spare_catalog(row[7], brand.name, false, false, false),
              :content => row[1]
            )
            begin
              to.save!
            rescue
              binding.pry
            end
            unless (model_from_csv = row[3].match(/\b(.+?)\b/)).nil?
              model = brand.models.find_or_create_by!(name: model_from_csv[0].mb_chars.upcase)
              generation = model.generations.find_or_create_by!(name: row[3])
              sr = SpareReplacement.find_or_initialize_by(from_spare_info: fr, to_spare_info: to)
              sr.save!
              sa = SpareApplicability.find_or_initialize_by(spare_info: fr, brand: brand, model: model, generation: generation)
              sa.save!
              sa = SpareApplicability.find_or_initialize_by(spare_info: to, brand: brand, model: model, generation: generation)
              sa.save!
            end
          end
      else
        puts "doesn't meet conditions #{row}"
      end
    end
  end
  end
end
