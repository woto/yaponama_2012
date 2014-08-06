# encoding: utf-8
#

namespace :app do

  namespace :brands do

    desc "Загузка брендов" 
    task :load => :environment do
      brands = JSON::load(File.read("#{Rails.root}/data/brands/brands.json"))
      brands.each do |brand|
        row = Brand.find_by_id(brand['id'])
        file_name = brand['image']['url']
        file_path = "#{Rails.root}/public#{file_name}"
        if row
          row.assign_attributes(brand)
          row.image = file_name ? File.open(CGI.unescape(file_path)) : nil
          begin
            row.save!
          rescue
            puts row.to_yaml
          end
        else
          row = Brand.new(brand)
          row.image = file_name ? File.open(CGI.unescape(file_path)) : nil
          begin
            row.save!
          rescue
            puts row.to_yaml
          end
        end
      end

      last_id = Brand.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE brands_id_seq RESTART WITH #{last_id+1}")

    end

    desc 'Сохранение брендов'
    task :save => :environment do
      File.write("#{Rails.root}/data/brands/brands.json", JSON.pretty_generate(Brand.order(:id).as_json(except: [:created_at, :updated_at])))
    end

  end

end
