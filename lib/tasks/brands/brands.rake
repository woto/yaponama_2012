# encoding: utf-8
#
namespace :app do

  namespace :brands do

    desc "Загузка брендов" 
    task :load => :environment do

    end

    desc 'Сохраняем бренды'
    task :save => :environment do
      File.write "#{Rails.root}/data/brands/brands.yml", Brand.all.to_yaml
    end

  end

end

