namespace :app do

  desc 'Прогон по прайсу. В данном случае надо чтобы инициировалась отправка данных spare_catalogs'
  task :progon, [:arg1] => [:environment] do |t, args|
    require 'csv'

    file = open(args[:arg1])

    file.each_line do |line|
      row = CSV.parse(line)[0]
      puts row
      open("http://www.avtorif.ru/user/products/new?catalog_number=#{CGI::escape(row[0].to_s)}")
    end

  end

  desc 'Проценка вызов происходит так: rake "app:protcenka[a]. Сравнение с прайсами, у которых visible_for_stock"'
  task :protcenka, [:arg1] => [:environment] do |t, args|
    require 'csv'

    file1 = open(args[:arg1])

    CSV.open("file.csv", "wb") do |csv|
      file1.each_line do |line|
        row = CSV.parse(line)[0]

        price_request_url = "http://#{SiteConfig.price_full_address}/prices/search?catalog_number=#{CGI::escape(row[0].to_s)}&manufacturer=#{CGI::escape(row[2].to_s)}&replacements=0&ext_ws=0&format=json&for_stock=1&cached=0"

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

  desc 'Скачиваем наши прайсы чтобы заполнить ими spare_infos'
  task :our_spare_infos => :environment do
    require 'csv'
    ['http://avtorif.ru:85/suppliers/67/price_settings/106/download',
     'http://avtorif.ru:85/suppliers/157/price_settings/265/download',
     'http://avtorif.ru:85/suppliers/156/price_settings/263/download',
     'http://avtorif.ru:85/suppliers/156/price_settings/264/download',
    ].each do |url|
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
    end
  end


  desc 'Отправляем не полученное сообщение на почту/телефон'
  task :talk_notifier => :environment  do
    while true do
      Talk.where(notified: false, read: false).where("created_at <= ?", 10.seconds.ago).each do |talk|
        talk.update_column(:notified, true)
        if talk.creator.buyer?
          SellerNotifierMailer.email(talk, 'info@avtorif.ru').deliver
        elsif talk.creator.seller?
          talk.somebody.profile.emails.each{|email| BuyerNotifierMailer.email(talk, email.value).deliver}
          talk.somebody.profile.phones.each{|phone| BuyerNotifierMailer.phone(talk, phone.value).deliver}
        end
      end
      sleep 1
    end
  end

end
