require 'csv'

class FebestComUaImport
  class << self
  def febest_com_ua_import
    febest = BrandMate.find_or_create_canonical('FEBEST')
    path = File.join(Rails.root, "catalog", "febest_com_ua.csv")
    CSV.foreach(path) do |row|
      if row[0].present? && row[1].present? && row[3].present? && row[7].present?

          c9 = row[0]
          b9 = 'FEBEST'
          r9 = '0'
          request_emex = '&ext_ws=0'
          cached = '&cached=0'

          #binding.pry
          price_request_url = "http://#{Rails.application.config_for('application/price')['host']}:#{Rails.application.config_for('application/price')['port']}/prices/search?catalog_number=#{CGI::escape(c9)}&manufacturer=#{CGI::escape(b9 || '')}&replacements=#{r9}#{request_emex}&format=json&for_site=1#{cached}"

          parsed_price_request_url = URI.parse(price_request_url)
          resp = Net::HTTP.get_response(parsed_price_request_url)
          @parsed_json = ActiveSupport::JSON.decode(resp.body)
          puts "not found #{row}"
          if @parsed_json["result_prices"].present?
            puts "found #{row}"
            brand = BrandMate.find_or_create_canonical!(row[6])
            fr = SpareInfo.find_or_initialize_by(:catalog_number => row[0].gsub(/[^a-z0-9]/i, ''), :brand => febest, content: row[1])
            fr.save!
            to = SpareInfo.find_or_initialize_by(:catalog_number => row[7].gsub(/[^a-z0-9]/i, ''), :brand => brand, content: row[1])
            to.save!
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
