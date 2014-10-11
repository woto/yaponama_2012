require 'csv'

class Progon
  def self.progon(arg1)
    file = open(arg1)
    file.each_line do |line|
      row = CSV.parse(line)[0]
      puts row
      open("http://#{CONFIG.site['host']}:#{CONFIG.site['port']}/user/products/new?catalog_number=#{CGI::escape(row[0].to_s)}")
    end
  end
end
