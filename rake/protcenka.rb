require 'csv'

class Protcenka

  def self.protcenka(t, args)

    file1 = open(args[:arg1])

    CSV.open("file.csv", "wb") do |csv|
      file1.each_line do |line|
        row = CSV.parse(line)[0]

        price_config = Rails.application.config_for('application/price')
        price_request_url = "http://#{price_config['host']}:#{price_config['port']}/prices/search?catalog_number=#{CGI::escape(row[0].to_s)}&manufacturer=#{CGI::escape(row[2].to_s)}&replacements=0&ext_ws=0&format=json&for_stock=1&cached=0"

        parsed_price_request_url = URI.parse(price_request_url)
        resp = Net::HTTP.get_response(parsed_price_request_url)
        parsed_json = ActiveSupport::JSON.decode(resp.body)

        price1 = row[6].to_i

        if parsed_json["result_prices"].any?
          price2 = parsed_json["result_prices"][0]["income_cost"].to_i
          coeff = (price1.to_f / price2.to_f).round(2)
        else
          coeff = 0
          price2 = 0
        end

        arr = [row[0], row[2], price1, price2, coeff]
        csv << arr
        csv.flush
        puts arr, '-'

      end
    end
  end
end
