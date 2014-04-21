# encoding: utf-8
#

namespace :app do

  namespace :bots do

    desc "Загрузка Ботов" 
    task :load => :environment do

      bots = JSON::load(File.read("#{Rails.root}/data/bots/bots.json"))
      bots.each do |bot|
        row = Bot.find_by_id(bot['id'])
        if row
          row.assign_attributes(bot)
        else
          row = Bot.new(bot)
        end
        row.save!
      end

      last_id = Bot.order(id: :desc).first.id
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE bots_id_seq RESTART WITH #{last_id+1}")

    end

    desc 'Сохранение ботов'
    task :save => :environment do

      File.write("#{Rails.root}/data/bots/bots.json", JSON.pretty_generate(Bot.order(:id).as_json(except: [:created_at, :updated_at])))

    end

  end

end
