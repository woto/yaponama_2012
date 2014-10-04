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
    Protcenka.protcenka t, args
  end

  desc 'Скачиваем наши прайсы чтобы заполнить ими spare_infos'
  task :our_spare_infos => :environment do
    require 'csv'
    ['http://avtorif.ru:85/suppliers/67/price_settings/106/download',
     'http://avtorif.ru:85/suppliers/157/price_settings/265/download',
     'http://avtorif.ru:85/suppliers/156/price_settings/266/download',
     'http://avtorif.ru:85/suppliers/156/price_settings/263/download',
     'http://avtorif.ru:85/suppliers/156/price_settings/264/download',
    ].each do |url|
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


  desc 'Отправляем не полученное сообщение на почту/телефон'
  task :talk_notifier => :environment  do
    while true do
      TalkNotifier.talk_notifier
      puts Time.zone.now
      sleep 1
    end
  end

  desc 'egrgroup_ru'
  task :egrgroup_ru => :environment do
    EgrgroupRu.egrgroup_ru
  end

  desc 'febest_com_ua'
  task :febest_com_ua => :environment do
    FebestComUa.febest_com_ua
  end

end
