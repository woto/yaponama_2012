# encoding: utf-8
#
module ProductsSearch

  extend ActiveSupport::Concern

  included do

    def initialize
      @status = { :offers => false }
      super
    end


    def set_retail_cost item
      #income_cost = case
      #  when item["supplier_title"] == "emex"
      #    Rails.application.config_for('application/price')['emex_income_rate'] * item["income_cost"]
      #  when item["supplier_title"] == "АВТОРИФ"
      #    item["income_cost"]
      #  else
      #    Rails.application.config_for('application/price')['avtorif_income_rate'] * item["retail_cost"]
      #  end

      income_cost = item['income_cost']
      retail_cost = item['retail_cost']
      #retail_cost = Rails.application.config_for('application/price')['retail_rate'] * income_cost

      # Скидка
      if current_user
        retail_cost = retail_cost - (retail_cost * current_user["discount"] / 100)
      end

      item["retail_cost"] = retail_cost.round
      item["income_cost"] = income_cost.round
    end

    private

    def search c9, b9, r9

      @c9 = c9
      @b9 = b9
      @r9 = r9

      plog = Logger.new Rails.root.join('log', 'prices.log')
      plog.formatter = Logger::Formatter.new

      plog.debug "-----------------------------"

      @parsed_json = { "result_prices" => [] }

      if c9.present?

        # Нужно для того чтобы если например набрали исключительно из символов, которые не попадают в допустимые и образуется пустая строка
        c9 = c9.gsub(/[^a-zA-Z0-9]/, '').upcase
        if c9.blank?
          render :status => 410 and return
        end

        request_emex = ''
        if Rails.application.config_for('application/price')['request_emex']
          request_emex = "&ext_ws=1"
        end

        price_request_cache_key = "#{c9}-#{b9}-#{r9}"

        plog.debug "Проверка наличия кеша"
        if Rails.cache.exist? price_request_cache_key
          @parsed_json = (Rails.cache.read(price_request_cache_key)).dup
          plog.debug "Кеш найден"
        else
          plog.debug "Кеш не найден"

          # TODO Что сделать с ситуцией. Если зашел робот, на сервере прайсов создалась кешированная версия, через день зашел пользователь,
          # все нормально. Я очистил тут кеш, зашел робот, взял кешированную версию (не запросил заново!) следом зашел пользователь и увидел 
          # самую первую версию. 
          #
          # Если поисковые системы, то согласны взять и закешированную версию
          #require 'netaddr'
          #cached = ''
          #APP_CONFIG['cached_ip'].each do |cidr_string|
          #  cidr = NetAddr::CIDR.create(cidr_string)
          #  if cidr.contains? request.remote_ip or cidr == request.remote_ip
          #    cached = '&cached=1'
          #    break
          #  end
          #end
          cached = '&cached=0'

          price_request_url = "http://#{Rails.application.config_for('application/price')['host']}:#{Rails.application.config_for('application/price')['port']}/prices/search?catalog_number=#{c9}&manufacturer=#{CGI::escape(b9 || '')}&replacements=#{r9}#{request_emex}&format=json&for_site=1#{cached}"

          parsed_price_request_url = URI.parse(price_request_url)

          begin
            require 'net/http'
            plog.debug "Запрос к серверу прайсов"
            #binding.pry
            resp = Net::HTTP.get_response(parsed_price_request_url)
            plog.debug "/Запрос к серверу прайсов"
          rescue Exception => e
            response.headers["Retry-After"] = (Time.now + 1.day).httpdate.to_s
            # @show_sidebar = true
            # TODO Не знаю почему, но для мобильной версии сделать не удалось (... .erb пробовал)
            # render :template => "/shared/503", :status => 503 and return
            render :status => 503 and return
          end

          #binding.pry
          @parsed_json = ActiveSupport::JSON.decode(resp.body)
          plog.debug 'Большой цикл очистки JSON'
          @parsed_json = ::PriceMate.clear(@parsed_json)
          plog.debug '/Большой цикл очистки JSON'


          if r9
            expires_in = Rails.application.config_for('application/price')['price_request_cache_with_replacements_in_seconds']
          else
            expires_in = Rails.application.config_for('application/price')['price_request_cache_without_replacements_in_seconds']
          end

          @parsed_json = PriceMate.sort_by_godness @parsed_json


          Rails.cache.write(price_request_cache_key, @parsed_json, :expires_in => expires_in)
          plog.debug 'Кеш записан'
        end

        #debugger

        plog.debug 'Большой цикл обработки JSON'
        @formatted_data = PriceMate.process @parsed_json
        plog.debug '/Большой цикл обработки JSON'

        plog.debug 'Сортировка по рейтингам брендов'
        @formatted_data = PriceMate.sort_by_brand_rating @formatted_data
        plog.debug '/Сортировка по рейтингам брендов'

        plog.debug 'Получаем сведения с текущей базы'
        @formatted_data = PriceMate.database @formatted_data
        plog.debug '/Получаем сведения с текущей базы'

      end

      @meta_title = "Поиск запчастей по номеру"

      if @formatted_data.blank?
        render :status => 404 and return
      else

        plog.debug 'Заполняем метаданные'


        plog.debug 'Keywords'
        @meta_keywords = PriceMate.meta_keywords @formatted_data
        plog.debug '/Keywords'

        titles = @formatted_data.map{|k, v| v.map{|kk, vv| vv[:titles]}}.map{|kkk| kkk.map{|kkkk| kkkk.to_a}}.flatten(2).sort{|kkkkk, vvvvv| kkkkk[1] <=> vvvvv[1]}.reverse.map{|kkkkk| kkkkk[0]}.uniq

        plog.debug 'Title'
        @meta_title = PriceMate.meta_title r9, titles, @formatted_data
        plog.debug '/Title'

        plog.debug 'Description'
        @meta_description = PriceMate.meta_description titles
        plog.debug '/Description'

        plog.debug 'Canonical'
        @meta_canonical = new_user_product_path(catalog_number: c9, replacements: r9)
        plog.debug '/Canonical'

        plog.debug '/Заполняем метаданные'

      end

      true
    end


  end

end
