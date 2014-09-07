# encoding: utf-8
#

namespace :app do

  namespace :spare_catalogs do

    desc "Загрузка каталогизатора товаров" 
    task :load => :environment do

      spare_catalogs = JSON::load(File.read("#{Rails.root}/data/spare_catalogs/spare_catalogs.json"))
      row = nil
      begin
        spare_catalogs.each do |spare_catalog|
          row = SpareCatalog.find_by_id(spare_catalog['id'])
          if row
            row.assign_attributes(spare_catalog)
          else
            row = SpareCatalog.new(spare_catalog)
          end
          row.save!
        end
      rescue StandardError => e
        binding.pry
      end

      last_id = SpareCatalog.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE spare_catalogs_id_seq RESTART WITH #{last_id+1}")

    end

    desc 'Сохранение каталогизатора товаров'
    task :save => :environment do

      File.write("#{Rails.root}/data/spare_catalogs/spare_catalogs.json", JSON.pretty_generate(SpareCatalog.order(:id).as_json(except: [:created_at, :updated_at])))

    end

  end

end
