require 'csv'

class OurSpareInfos
  def self.our_spare_infos args
    # 'http://avtorif.ru:85/suppliers/156/price_settings/264/download',
    #].each do |url|
    #
    # TODO дописать
    #args.each do |url|
      begin
        open(url) do |f|
          f.each_line do |line|
            row = CSV.parse(line)[0]
            begin
              SpareInfo.create(catalog_number: row[1], brand: Brand.where(name: row[3].to_s.upcase).first_or_initialize, content: row[4])
            rescue
            end
            puts row
          end
        end
      rescue Exception => e
        puts url
      end
    end
  end
end
