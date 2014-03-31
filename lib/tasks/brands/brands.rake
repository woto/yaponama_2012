# encoding: utf-8
#

namespace :app do

  namespace :brands do

    desc "Загузка брендов" 
    task :load => :environment do
      brands = JSON::load(File.read("#{Rails.root}/data/brands/brands.json"))
      brands.each do |brand|
        row = Brand.find(brand['id'])
        row.update(brand) if brand
      end
    end

    desc 'Сохраняем бренды'
    task :save => :environment do
        File.write("#{Rails.root}/data/brands/brands.json", JSON.pretty_generate(Brand.all.as_json))
    end

  end

end
