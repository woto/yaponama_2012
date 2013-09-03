class SiteConfig

  @@lock = Mutex.new
  @@cache = nil

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

        # Такой способ лучше, если конечно он написан правильно :)
        # в тестах, необходимо насильно сбрасывать кеш
        # SiteConfig.class_variable_set(:@@cache, nil)
        
        @@lock.synchronize do
          @@cache ||= Admin::SiteSetting.where(:environment => Rails.env).first
          raise NoMethodError if @@cache.blank?
        end
        
        return @@cache.send(meth)

        #Rails.logger.silence do
        #  record = Admin::SiteSetting.where(:environment => Rails.env).first
        #  if record.blank?
        #    raise NoMethodError
        #  else
        #    return record.send(meth)
        #  end
        #end

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
