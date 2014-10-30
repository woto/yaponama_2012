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
  task :our_spare_infos, [:args] => [:environment] do |t, args|
    # TODO дописать
    #OurSpareInfos.our_spare_infos args
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
