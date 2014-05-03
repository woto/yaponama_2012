# encoding: utf-8
#

namespace :app do

  namespace :cars do

    desc "Загузка автомобилей" 
    task :load => :environment do

      models = JSON::load(File.read("#{Rails.root}/data/cars/models.json"))
      models.each do |model|
        row = Model.find_by_id(model['id'])
        if row
          row.assign_attributes(model)
        else
          row = Model.new(model)
        end
        row.save!
      end

      last_id = Model.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE models_id_seq RESTART WITH #{last_id+1}")

      generations = JSON::load(File.read("#{Rails.root}/data/cars/generations.json"))
      generations.each do |generation|
        row = Generation.find_by_id(generation['id'])
        if row
          row.assign_attributes(generation)
        else
          row = Generation.new(generation)
        end
        row.save!
      end

      last_id = Generation.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE generations_id_seq RESTART WITH #{last_id+1}")

      modifications = JSON::load(File.read("#{Rails.root}/data/cars/modifications.json"))
      modifications.each do |modification|
        row = Modification.find_by_id(modification['id'])
        if row
          row.assign_attributes(modification)
        else
          row = Modification.new(modification)
        end
        row.save!
      end

      last_id = Modification.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE modifications_id_seq RESTART WITH #{last_id+1}")

    end

    desc 'Сохранение автомобилей'
    task :save => :environment do

      File.write("#{Rails.root}/data/cars/models.json", JSON.pretty_generate(Model.order(:id).as_json(except: [:created_at, :updated_at])))
      File.write("#{Rails.root}/data/cars/generations.json", JSON.pretty_generate(Generation.order(:id).as_json(except: [:created_at, :updated_at])))
      File.write("#{Rails.root}/data/cars/modifications.json", JSON.pretty_generate(Modification.order(:id).as_json(except: [:created_at, :updated_at])))

    end

  end

end
