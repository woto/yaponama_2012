require 'csv'

class Progon
  def self.progon(arg1)
    file = open(arg1)
    file.each_line do |line|
      row = CSV.parse(line)[0]
      puts row
      open("http://#{Rails.application.config_for('application/site')['host']}:#{Rails.application.config_for('application/site')['port']}/user/products/new?catalog_number=#{CGI::escape(row[0].to_s)}")
    end
  end
end
