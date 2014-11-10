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

        counter = Hash.new{|h, k| h[k] = 0}

        @formatted_data = {}

        plog.debug 'Большой цикл обработки JSON'
        @parsed_json["result_prices"].each do |item|
          # Необходимо поступать так, т.к. только в момент разбора можем понять есть если ли что-нибудь или нет
          # т.к. необходимо игнорировать точки и не нулевая длина массива еще не показатель, что есть что отображать
          unless @status[:offers]
            @status[:offers] = true
          end

          cn = item["catalog_number"].to_s
          canonical_brand = BrandMate.find_or_create_canonical!(item["manufacturer"])
          mf = canonical_brand.name.to_s

          h = cn + " - " + mf
          counter[h] += 1

          if counter[h] <= 5
            set_retail_cost item

            # Если нет такого каталожника, создаем
            unless @formatted_data.include?(cn)
              @formatted_data[cn] = {}
            end

            # Если нет такого производителя, создаем производителя и внутри него структуру
            unless @formatted_data[cn].include? mf

              @formatted_data[cn][mf] = {
                :titles => {},
                :manufacturer_origs => {},
                :catalog_number_origs => {},
                :weights => {},
                :min_days => nil,
                :max_days => nil,
                :min_cost => nil,
                :max_cost => nil,
                :offers => [],
                :brand => canonical_brand,
                # image_url у всех одинаковый по определению, т.к. берется из price_catalogs
                # несмотря на то, что на сервере прайсов заполняется по образу weights
                #:image_url => item["image_url"]
              }

            end


            techs = ["supplier_title", "supplier_title_full", "price_logo_emex", "job_title", "supplier_title_en", "income_cost"]

            @formatted_data[cn][mf][:offers].push({
              :country => item["job_import_job_country_short"],
              :min_days => [ item["job_import_job_delivery_days_declared"], item["job_import_job_delivery_days_average"] ].compact.min,
              :max_days => [ item["job_import_job_delivery_days_declared"], item["job_import_job_delivery_days_average"] ].compact.max,
              :probability => item["success_percent"],
              :retail_cost => item["retail_cost"],
              :count => item["count"],
              :title => '',
              :delivery => item["job_import_job_delivery_summary"],
              :income_cost => item["income_cost"],
              :tech => techs.map{|tech| item[tech].to_s}.reject(&:blank?).join(', ')
            })

            # Мин. кол-во дней
            comparsion = @formatted_data[cn][mf][:min_days].nil? ? [] : [@formatted_data[cn][mf][:min_days]]
            if item["job_import_job_delivery_days_average"].present?
              comparsion.push item["job_import_job_delivery_days_average"]
            end
            if item["job_import_job_delivery_days_declared"].present?
              comparsion.push item["job_import_job_delivery_days_declared"]
            end
            @formatted_data[cn][mf][:min_days] = comparsion.min

            # Макс. кол-во дней
            comparsion = @formatted_data[cn][mf][:max_days].nil? ? [] : [@formatted_data[cn][mf][:max_days]]
            if item["job_import_job_delivery_days_average"].present?
              comparsion.push item["job_import_job_delivery_days_average"]
            end
            if item["job_import_job_delivery_days_declared"].present?
              comparsion.push item["job_import_job_delivery_days_declared"]
            end
            @formatted_data[cn][mf][:max_days] = comparsion.max

            # Мин. цена
            comparsion = @formatted_data[cn][mf][:min_cost].nil? ? [] : [@formatted_data[cn][mf][:min_cost]]
            comparsion.push item["retail_cost"]
            @formatted_data[cn][mf][:min_cost] = comparsion.min

            # Макс. цена
            comparsion = @formatted_data[cn][mf][:max_cost].nil? ? [] : [@formatted_data[cn][mf][:max_cost]]
            comparsion.push item["retail_cost"]
            @formatted_data[cn][mf][:max_cost] = comparsion.max

          end

          ["title", "title_en", "description", "applicability", "parts_group"].each do |field_title|
            if item[field_title].present?
              title = item[field_title].to_s.mb_chars.upcase.to_s
              unless @formatted_data[cn][mf][:titles][title]
                @formatted_data[cn][mf][:titles][title] = 1
              else
                @formatted_data[cn][mf][:titles][title] += 1
              end
            end
          end

          manufacturer_orig = item["manufacturer_orig"].to_s.mb_chars.upcase.to_s
          catalog_number_orig = item["catalog_number_orig"].to_s.mb_chars.upcase.to_s
          weight = ((tmp = item["weight_grams"].to_f) > 0 ? ((tmp + 100) / 1000).round(1) : nil)

          # Запоминаем количество повторений одного и того же оригинального написания кат. номера
          if catalog_number_orig.present? && catalog_number_orig != cn
            unless @formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig]
              @formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig] = 1
            else
              @formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig] += 1
            end
          end

          # Запоминаем количество повторений одного и того же оригинального производителя
          if manufacturer_orig.present? && manufacturer_orig != mf
            unless @formatted_data[cn][mf][:manufacturer_origs][manufacturer_orig]
              @formatted_data[cn][mf][:manufacturer_origs][manufacturer_orig] = 1
            else
              @formatted_data[cn][mf][:manufacturer_origs][manufacturer_orig] += 1
            end
          end

          # Запоминаем количество повторений одного и того же веса
          if weight.present?
            unless @formatted_data[cn][mf][:weights][weight]
              @formatted_data[cn][mf][:weights][weight] = 1
            else
              @formatted_data[cn][mf][:weights][weight] += 1
            end
          end

        end
        plog.debug '/Большой цикл обработки JSON'

        @formatted_data = PriceMate.sort_by_brand_rating @formatted_data

        plog.debug 'Получаем сведения с текущей базы'
        @formatted_data = PriceMate.database @formatted_data
        plog.debug '/Получаем сведения с текущей базы'

      end

      @meta_title = "Поиск запчастей по номеру"

      unless @status[:offers]
        render :status => 404 and return
      else
        plog.debug 'Заполняем метаданные'

        # Keywords
        keywords = Hash.new {|hash,key| hash[key] = 0}
        @formatted_data.map{|k, v| v.map{|kk, vv| vv[:titles].map{|kkk, vvv| kkk}}}.flatten.join(', ').split(/[, ]/).reject{|kkk| kkk.size < 2}.each { |word| keywords[word] += 1 }
        keywords = keywords.sort{|k, v| k[1] <=> v[1]}.reverse
        keywords = keywords[0, (keywords.size/4.0).round]
        @meta_keywords = keywords.map{|k, v| k}.join(', ')
        # /Keywords

        titles = @formatted_data.map{|k, v| v.map{|kk, vv| vv[:titles]}}.map{|kkk| kkk.map{|kkkk| kkkk.to_a}}.flatten(2).sort{|kkkkk, vvvvv| kkkkk[1] <=> vvvvv[1]}.reverse.map{|kkkkk| kkkkk[0]}.uniq

        # Title
        @meta_title = ''
        if r9.present?
          @meta_title << "Замены и аналоги #{c9} "
          @meta_title << "#{b9} " if b9
        else
          # Каталожник тут всегда будет 1? TODO
          @meta_title << @formatted_data.map{|k, v| k}.flatten.uniq.reject{|kk| kk.size < 2}[0, 2].join(', ')
          # Производители
          @meta_title << " "
          @meta_title << @formatted_data.map{|k, v| v.map{|kk, vv| kk}}.flatten.uniq.reject{|kk| kk.size < 2}[0, 5].join(', ')
          @meta_title << " "
        end
        @meta_title << titles[0].to_s.mb_chars.capitalize
        
        # /Title
        
        # Description
        @meta_description = ''
        # Названия
        if titles.size > 1
          @meta_description << titles[1, 3].join(', ').mb_chars.capitalize
        else
          @meta_description << titles[0].to_s.mb_chars.capitalize
        end
        @meta_description << ". Удобная оплата. Отправка в регионы, доставка по Москве, самовывоз Рязанский и Ленинградский проспект."
        # /Description

        # Canonical
        @meta_canonical = new_user_product_path(catalog_number: c9, replacements: r9)
        # /Canonical

        plog.debug '/Заполняем метаданные'
      end

      true
    end


  end

end
