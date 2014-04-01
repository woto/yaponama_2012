# encoding: utf-8
#

namespace :app do

  namespace :faqs do

    desc "Загузка частых вопросов" 
    task :load => :environment do

      faqs = JSON::load(File.read("#{Rails.root}/data/faqs/faqs.json"))
      faqs.each do |faq|
        row = Faq.find_by_id(faq['id'])
        if row
          row.assign_attributes(faq)
        else
          row = Faq.new(faq)
        end
        row.save
      end

    end

    desc 'Сохранение частых вопросов'
    task :save => :environment do

      File.write("#{Rails.root}/data/faqs/faqs.json", JSON.pretty_generate(Faq.order(:id).as_json(except: [:created_at, :updated_at])))

    end

  end

end
