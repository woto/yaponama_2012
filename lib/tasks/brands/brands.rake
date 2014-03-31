# encoding: utf-8
#

namespace :app do

  namespace :brands do

    desc "Загузка брендов" 
    task :load => :environment do
      brands = JSON::load(File.read("#{Rails.root}/data/brands/brands.json"))
      brands.each do |brand|
        row = Brand.find_by_id(brand['id'])
        if row
          row.assign_attributes(brand)
          row.image = File.open("#{Rails.root}/public#{brand['image']['url']}")
          row.save
        else
          row = Brand.new(brand)
          row.image = File.open("#{Rails.root}/public#{brand['image']['url']}")
          row.save
        end
      end
    end

    desc 'Сохраняем бренды'
    task :save => :environment do
        File.write("#{Rails.root}/data/brands/brands.json", JSON.pretty_generate(Brand.order(:name).as_json(except: [:created_at, :updated_at])))
    end

  end

end
