class SiteConfig

  include ActiveModel

  class << self

    include ConfigHelper

    def created_at
      DateTime.now
    end

    def updated_at
      DateTime.now
    end

    def environment
      Rails.env
    end


    def method_missing(meth, *args, &block)
      begin
        # Пытаемся получить аттрибут с условием текущего environment
        Admin::SiteSetting.where(:environment => Rails.env).first.send(meth)
      rescue Exception => e
        # Не удается, тогда загружаем конфиг
        config = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
        # Дописываем в него environment
        config['environment'] = Rails.env
        # Если таблица еще не готова
        if e.is_a? ActiveRecord::ActiveRecordError
          # То просто возвращаем результат
          config[meth.to_s]
        # Иначе еще и создаем копию текущих настроек в таблице
        elsif e.is_a? NoMethodError
          Admin::SiteSetting.create!(config)
          config[meth.to_s]
        else
          raise e
        end
      end
    end

  end

end
