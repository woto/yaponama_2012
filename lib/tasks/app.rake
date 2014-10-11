namespace :catalog do

  desc 'egrgroup_ru_import'
  task :egrgroup_ru_import => :environment do
    EgrgroupRuImport.egrgroup_ru_import
  end

  desc 'febest_com_ua_import'
  task :febest_com_ua_import => :environment do
    FebestComUaImport.febest_com_ua_import
  end


end

namespace :app do

  desc 'Прогон по прайсу. В данном случае надо чтобы инициировалась отправка данных spare_catalogs'
  task :progon, [:arg1] => [:environment] do |t, args|
    Progon.progon args[:arg1]
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

  desc 'pg_dump'
  task :pg_dump => :environment do
    PgDump.pg_dump
  end

  desc 'pg_restore'
  task :pg_restore => :environment do
    PgRestore.pg_restore
  end

end
