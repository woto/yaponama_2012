namespace :app do

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

    Net::IMAP.debug = true

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
                  puts err
                end
                sleep 3
              end
            rescue StandardError
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
