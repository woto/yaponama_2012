namespace :app do

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

  desc "Почтоприемщик"
  task :imap_receive => :environment do
    require 'rubygems'
    require 'net/imap'
    require 'mail'
    require 'pry'

    Net::IMAP.debug = false

    class MyMail
      def initialize
        @idler_thread = Thread.new do
          loop do
            begin
              #@imap= Net::IMAP.new('imap.gmail.com', port: '993', ssl: true)
              @imap= Net::IMAP.new('imap.yandex.ru', port: '993', ssl: true)
              @imap.login('info@avtorif.ru','ASD123qwe')

              loop do
                begin
                  @imap.select("INBOX")
                  process()
                rescue IOError
                  raise 'reconnect'
                rescue StandardError => err
                  #puts err
                end
                sleep 3
              end
            rescue StandardError => err
              #puts err
              #binding.pry
              sleep 3
            end
          end
        end
        @idler_thread.run
        @idler_thread.join
      end

      def process
        @imap.search('ALL').each do |message_id|
          mail = Mail.new @imap.fetch(message_id, "RFC822")[0].attr["RFC822"]
          puts mail.subject
          @imap.store(message_id, "+FLAGS", [:Deleted])
          @imap.expunge
          ReceiveMailer.receive mail
        end
      end

    end

    MyMail.new

  end

end
