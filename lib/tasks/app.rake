#http://8xx8.ru/blog/2012/12/10/katalogh-lib-v-rails/
#http://stackoverflow.com/questions/18894060/rails-and-minitest-add-additional-folder


# rake test:rake
namespace :test do
  desc "Run tests for rake"
  Rails::TestTask.new(:rake) do |t|
    t.libs << "test"
    t.pattern = 'test/rake/**/*_test.rb'
  end
end

lib_task = Rake::Task["test:rake"]
test_task = Rake::Task[:test]
test_task.enhance { lib_task.invoke }


namespace :catalog do

  # rake catalog:egrgroup_ru_grab
  Rails::TestTask.new(:egrgroup_ru_grab) do |t|
    t.libs << "test"
    t.pattern = 'catalog/egrgroup_ru_grab.rb'
  end

  # rake catalog:egrgroup_ru_import
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

  task :update_spare_catalog => :environment do
    UpdateSpareCatalog.update_spare_catalog
  end

  task :update_brand => :environment do
    UpdateBrand.update_brand
  end

  desc 'Проценка вызов происходит так: rake "app:protcenka[a]. Сравнение с прайсами, у которых visible_for_stock"'
  task :protcenka, [:arg1] => [:environment] do |t, args|
    Protcenka.protcenka t, args
  end

  task :import_spare_info, 100.times.map { |i| "arg#{i}".to_sym } => [:environment] do |t, args|
    ImportSpareInfo.import_spare_info args
  end

  desc 'Отправляем не полученное сообщение на почту/телефон'
  task :talk_notifier => :environment  do
    while true do
      TalkNotifier.talk_notifier
      puts Time.zone.now
      sleep 1
    end
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
