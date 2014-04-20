# encoding: utf-8
#

namespace :app do

  namespace :spare_catalogs do

    desc "Загрузка каталогизатора товаров" 
    task :load => :environment do

      spare_catalogs = JSON::load(File.read("#{Rails.root}/data/spare_catalogs/spare_catalogs.json"))
      spare_catalogs.each do |spare_catalog|
        row = SpareCatalog.find_by_id(spare_catalog['id'])
        if row
          row.assign_attributes(spare_catalog)
        else
          row = SpareCatalog.new(spare_catalog)
        end
        row.save
      end

    end

    desc 'Сохранение каталогизатора товаров'
    task :save => :environment do

      File.write("#{Rails.root}/data/spare_catalogs/spare_catalogs.json", JSON.pretty_generate(SpareCatalog.order(:id).as_json(except: [:created_at, :updated_at])))

    end

  end

end
