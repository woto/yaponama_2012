# encoding: utf-8
#

namespace :app do

  namespace :spare_infos do

    desc "Загрузка каталогизатора товаров" 
    task :load => :environment do

      spare_infos = JSON::load(File.read("#{Rails.root}/data/spare_infos/spare_infos.json"))
      spare_infos.each do |spare_catalog|
        row = SpareInfo.find_by_id(spare_catalog['id'])
        if row
          row.assign_attributes(spare_catalog)
        else
          row = SpareInfo.new(spare_catalog)
        end
        row.save!
      end

      last_id = SpareInfo.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE spare_infos_id_seq RESTART WITH #{last_id+1}")

    end

    desc 'Сохранение каталогизатора товаров'
    task :save => :environment do

      File.write("#{Rails.root}/data/spare_infos/spare_infos.json", JSON.pretty_generate(SpareInfo.order(:id).as_json(except: [:created_at, :updated_at])))

    end

  end

end
