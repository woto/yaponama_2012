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

  Dir.glob('catalog/*grab*').each do |file|
    lowcase = file.scan(/(?<=catalog\/).*(?=\_grab.rb)/)[0]
    upcase = lowcase.classify
    eval <<-EOL
      desc '#{lowcase}_grab'
      task :#{lowcase}_grab => :environment do
        #{upcase}Grab.#{lowcase}_grab
      end
    EOL
  end

  Dir.glob('catalog/*import*').each do |file|
    lowcase = file.scan(/(?<=catalog\/).*(?=\_import.rb)/)[0]
    upcase = lowcase.classify
    eval <<-EOL
      desc '#{lowcase}_import'
      task :#{lowcase}_import => :environment do
        #{upcase}Import.#{lowcase}_import
      end
    EOL
  end

end


namespace :app do

  desc 'Открываем поочередно страницы нашего сайта'
  task :progon => :environment do
    #while true do
      Progon.progon
      puts 'done!'
      #puts Time.zone.now
      #sleep 1
    #end
  end

  desc 'Выгрузка конгломераций в виде "Toyota Lexus,Toyota"'
  task :unload_conglomerates => :environment do
    UnloadConglomerates.unload_conglomerates
  end

  task :y => :environment do
    Y.y
  end

  task :destroy_old_bots => :environment do
    DestroyOldBots.destroy_old_bots
  end

  task :destroy_old_spare_infos => :environment do
    DestroyOldSpareInfos.destroy_old_spare_infos
  end



  task :download_warehouse => :environment do
    DownloadWarehouse.download_warehouse
  end

  task :update_spare_catalog => :environment do
    UpdateSpareCatalog.update_spare_catalog
  end

  task :update_brand => :environment do
    UpdateBrand.update_brand
  end

  task :create_new_wordstat_report_spare_info => :environment do
    CreateNewWordstatReportSpareInfo.create_new_wordstat_report_spare_info
  end

  task :create_new_wordstat_report_spare_catalog => :environment do
    CreateNewWordstatReportSpareCatalog.create_new_wordstat_report_spare_catalog
  end

  desc 'Проценка вызов происходит так: rake "app:protcenka[a]. Сравнение с прайсами, у которых visible_for_stock"'
  task :protcenka, [:arg1] => [:environment] do |t, args|
    Protcenka.protcenka t, args
  end

  desc 'Проставка значений brands_spare_catalogs'
  task :fill_brands_spare_catalogs => :environment do
    FillBrandsSpareCatalogs.fill_brands_spare_catalogs
  end

  task :import_spare_info, 100.times.map { |i| "arg#{i}".to_sym } => [:environment] do |t, args|
    ImportSpareInfo.import_spare_info args
  end

end
