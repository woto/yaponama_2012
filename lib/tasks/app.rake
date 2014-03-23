namespace :app do

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
