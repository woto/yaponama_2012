require 'csv'

class EgrgroupRuImport
    def self.egrgroup_ru_import
      path = File.join(Rails.root, 'catalog', 'egrgroup_ru.csv')
      CSV.foreach(path) do |row|

        if !row[1].blank? && !row[2].blank? && !row[3].blank? && !row[4].blank? && !row[5].blank? && !row[6].blank? && !row[7].blank?

          c9 = row[1]
          b9 = row[3]
          r9 = '0'
          request_emex = '&ext_ws=0'
          cached = '&cached=0'

          #binding.pry
          price_request_url = "http://#{Rails.application.config_for('application/price')['host']}:#{Rails.application.config_for('application/price')['port']}/prices/search?catalog_number=#{CGI::escape(c9)}&manufacturer=#{CGI::escape(b9 || '')}&replacements=#{r9}#{request_emex}&format=json&for_site=1#{cached}"

          parsed_price_request_url = URI.parse(price_request_url)
          resp = Net::HTTP.get_response(parsed_price_request_url)
          @parsed_json = ActiveSupport::JSON.decode(resp.body)
          #binding.pry
          if @parsed_json["result_prices"].present?

            brand = BrandMate.find_or_create_canonical(row[3])
            model = Model.find_or_create_by(name: row[4], brand: brand)
            generation = Generation.find_or_create_by(name: row[2], model: model)

            manufacturer = Brand.find_or_create_by(name: row[5])
            spare_catalog = SpareCatalog.find_or_create_by(name: row[6].mb_chars.upcase, content: row[6].mb_chars.upcase)
            spare_info = SpareInfo.find_or_create_by(catalog_number: row[1].gsub('-', ''), brand: manufacturer, spare_catalog: spare_catalog, content: row[7])

            s = SpareApplicability.new(
              spare_info: spare_info,
              brand: brand,
              model: model,
              generation: generation
            )

            unless s.save
              puts row.to_s
              #binding.pry
           end
          end
        end
      end
    end
end
