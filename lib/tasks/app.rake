namespace :app do

  desc "Забиратель почты - тест"
  task :imap_receive => :environment do
    require 'rubygems'
    require 'net/imap'
    require 'mail'
    require 'pry'

    Net::IMAP.debug = true


    class MyMail
      def initialize
        #@imap= Net::IMAP.new('imap.gmail.com', port: '993', ssl: true)
        @imap= Net::IMAP.new('imap.yandex.ru', port: '993', ssl: true)
        @imap.login('robot@avtorif.ru','123123')

        @idler_thread = Thread.new do
          loop do
            begin
              @imap.select("INBOX")
              process()
            rescue StandardError => err
              puts err
            end
            sleep 3
          end
        end
        @idler_thread.run
        @idler_thread.join
      end

      def process
        @imap.search('ALL').each do |message_id|
          mail = Mail.new @imap.fetch(message_id, "RFC822")[0].attr["RFC822"]
          puts mail.subject
          ReceiveMailer.receive mail
          @imap.store(message_id, "+FLAGS", [:Deleted])
          @imap.expunge
        end
      end

    end

    MyMail.new

  end

end
