#encoding: utf-8

class SearchesController < ApplicationController

  def initialize
    @status = {:offers => false, :page => false}
    super
  end

  def set_retail_cost item
    income_cost = case
      when item["supplier_title"] == "emex"
        SiteConfig.emex_income_rate * item["income_cost"]
      when item["supplier_title"] == "АВТОРИФ"
        item["income_cost"]
      else
        SiteConfig.avtorif_income_rate * item["retail_cost"]
      end

    retail_cost = SiteConfig.retail_rate * income_cost

    # Скидка
    if current_user
      retail_cost = retail_cost - (retail_cost * current_user["discount"] / 100)
    end

    item["retail_cost"] = retail_cost.round
    item["income_cost"] = income_cost.round
  end


  def set_meta_robots
    #if params[:replacements]
    #  @meta_robots = 'noindex, follow'
    #else
    #  @meta_robots = 'index, follow'
    #end
  end


  def index

    @parsed_json = { "result_prices" => [] }

    if params[:catalog_number].present?

      # Нужно для того чтобы если например набрали исключительно из символов, которые не попадают в допустимые и образуется пустая строка
      params[:catalog_number] = params[:catalog_number].gsub(/[^a-zA-Z0-9]/, '').upcase
      if params[:catalog_number].blank?
        render :status => 410 and return
      end

      seo_url = polymorphic_path([:search, (admin_zone? ? :admin : :user), (admin_zone? ? @somebody : nil), :searches], :catalog_number => params[:catalog_number].present? ? params[:catalog_number] : nil, :manufacturer => params[:manufacturer].present? ? params[:manufacturer] : nil, :replacements => params[:replacements].to_i > 0 ? '1' : nil)
      if request.fullpath.upcase != seo_url.upcase
        respond_to do |format|
          format.html { redirect_to seo_url, :status => 301 and return }
        end
      end

      set_meta_robots

      request_emex = ''
      if SiteConfig.request_emex
        request_emex = "&ext_ws=1"
      end

      price_request_cache_key = "#{params[:catalog_number]}-#{params[:manufacturer]}-#{params[:replacements]}"

      if Rails.cache.exist? price_request_cache_key
        @parsed_json = (Rails.cache.read(price_request_cache_key)).dup
      else

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

        price_request_url = "http://#{SiteConfig.price_full_address}/prices/search?catalog_number=#{params[:catalog_number]}&manufacturer=#{CGI::escape(params[:manufacturer] || '')}&replacements=#{params[:replacements]}#{request_emex}&format=json&for_site=1#{cached}"

        parsed_price_request_url = URI.parse(price_request_url)

        begin
          require 'net/http'
          resp = Net::HTTP.get_response(parsed_price_request_url)
        rescue Exception => e
          response.headers["Retry-After"] = (Time.now + 1.day).httpdate.to_s
          # @show_sidebar = true
          # TODO Не знаю почему, но для мобильной версии сделать не удалось (... .erb пробовал)
          # render :template => "/shared/503", :status => 503 and return
          render :status => 503 and return
        end

        @parsed_json = ActiveSupport::JSON.decode(resp.body)
        @parsed_json.delete("result_replacements")
        @parsed_json.delete("result_message")
        @parsed_json["result_prices"].map do |item|
          item.delete "ij_income_rate"
          item.delete "ps_retail_rate"
          item.delete "income_cost_in_currency_with_weight"
          item.delete "supplier_inn"
          item.delete "logo"
          item.delete "job_import_job_destination_logo"
          item.delete "retail_cost_with_discounts"
          item.delete "job_import_job_kilo_price"
          item.delete "bit_original"
          item.delete "price_cost"
          item.delete "supplier_kpp"
          item.delete "c_weight_value"
          item.delete "ps_absolute_weight_rate"
          item.delete "manufacturer_short"
          item.delete "price_group"
          item.delete "ps_weight_unavailable_rate"
          item.delete "c_buy_value"
          item.delete "currency"
          item.delete "ps_relative_weight_rate"
          item.delete "ps_kilo_price"
          item.delete "ps_absolute_buy_rate"
          item.delete "ps_relative_buy_rate"
          item.delete "income_cost_in_currency_without_weight"
          item.delete "image_url"
          item.delete "created_at"
          item.delete "price_setting_id"
          item.delete "image_url"
          item.delete "ij_income_rate"
          item.delete "ps_retail_rate"
          item.delete "min_order"
          item.delete "updated_at"
          item.delete "external_id"
          item.delete "unit_package"
          item.delete "supplier_inn"
          item.delete "retail_cost_with_discounts"
          item.delete "id"
          item.delete "price_cost"
          item.delete "processed"
          item.delete "job_import_job_kilo_price"
          item.delete "bit_original"
          item.delete "unit"
          item.delete "supplier_kpp"
          item.delete "c_weight_value"
          item.delete "supplier_id"
          item.delete "ps_absolute_weight_rate"
          item.delete "external_supplier_id"
          item.delete "currency"
          item.delete "c_buy_value"
          item.delete "ps_weight_unavailable_rate"
          item.delete "md5"
          item.delete "job_id"
          item.delete "minimal_income_cost"
          item.delete "income_cost_in_currency_without_weight"
          item.delete "ps_relative_buy_rate"
          item.delete "ps_absolute_buy_rate"
          item.delete "ps_kilo_price"
          item.delete "ps_relative_weight_rate"
          item.delete "multiply_factor"
          item.delete "job_import_job_presence"
          item.delete "job_import_job_output_order"
          item.delete "real_job_id"
        end


        if params[:replacements]
          expires_in = SiteConfig.price_request_cache_with_replacements_in_seconds
        else
          expires_in = SiteConfig.price_request_cache_without_replacements_in_seconds
        end

        #@parsed_json["result_prices"].shuffle!
         
        @parsed_json["result_prices"] = @parsed_json["result_prices"].sort_by { |a|  ( ( (a["job_import_job_delivery_days_average"].present? ? a["job_import_job_delivery_days_average"] : a["job_import_job_delivery_days_declared"]).to_f + a["job_import_job_delivery_days_declared"].to_f)/2/( (fast = params[:fast]).present? ? fast.to_f : 100) ) +  a["price_goodness"].to_f }

        Rails.cache.write(price_request_cache_key, @parsed_json, :expires_in => expires_in)
      end

      #debugger

      counter = Hash.new{|h, k| h[k] = 0}

      @formatted_data = {}

      @parsed_json["result_prices"].each do |item|
        next if item["job_import_job_country_short"].nil? || item["job_import_job_country_short"].include?("avtorif.ru")

        # Необходимо поступать так, т.к. только в момент разбора можем понять есть если ли что-нибудь или нет
        # т.к. необходимо игнорировать точки и не нулевая длина массива еще не показатель, что есть что отображать
        unless @status[:offers]
          @status[:offers] = true
        end

        h = item["catalog_number"].to_s + " - " + item["manufacturer"].to_s
        counter[h] += 1

        cn = item["catalog_number"].to_s
        mf = item["manufacturer"].to_s

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
              #:brand => Brands::BRANDS[mf],
              :brand => Brand.where(:name => mf).first,
              :info => item_status(item['catalog_number'], item['manufacturer']),
            }

            #@manufacturers = mf

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
            :tech => techs.map {|tech| item[tech].to_s + ", "}.to_s
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
        if catalog_number_orig.present? && catalog_number_orig != item["catalog_number"]
          unless @formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig]
            @formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig] = 1
          else
            @formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig] += 1
          end
        end

        # Запоминаем количество повторений одного и того же оригинального производителя
        if manufacturer_orig.present? && manufacturer_orig != item["manufacturer"]
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

      # Сортируем в конце по цене
      @formatted_data = @formatted_data.map do |catalog_number, cn_scope|
        [ catalog_number,
          (cn_scope.sort do |a, b|
          -(a[1][:brand].try(:[], :rating).try(:to_i) || 0) <=> -(b[1][:brand].try(:[], :rating).try(:to_i) || 0)
          end).map do |manufacturer, mf_scope|
            [manufacturer, mf_scope.merge(:offers => mf_scope[:offers].sort do |c, d|
              c[:retail_cost] <=> d[:retail_cost]
            end)]
         end
        ]
      end

      # Получаем общее для связки каталожный номер + производитель имя
      @formatted_data.each do |catalog_number, cn_scope|
        cn_scope.each do |manufacturer, mf_scope|
          mf_scope[:title] = (mf_scope[:titles].sort_by{|a, b| -b} + ([["", 0]]))[0][0]
        end
      end


      @meta_canonical = polymorphic_path([:search, :user, :searches], :catalog_number => params[:catalog_number], :manufacturer => params[:manufacturer].present? ? params[:manufacturer] : nil, :replacements => params[:replacements].to_i > 0 ? '1' : nil)
    else
      @meta_title = "Поиск запчастей по номеру"
    end

    if @formatted_data.present?

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
      if params[:replacements].present?
        @meta_title << "Замены #{params[:catalog_number]} "
        @meta_title << "#{params[:manufacturer]} " if params[:manufacturer]
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
      @meta_description << ". Удобная оплата. Отправка в регионы, доставка по Москве, самовывоз м. Динамо, Аэропорт."
      # /Description
    end

    unless params.include?(:skip) || @status.any?{|k, v| v}
      render :status => 404 and return
    end

    respond_to do |format|
      format.html { render "index" }
      format.js { render "index" }
    end

  end

  private

  def user_set
    @somebody = @user = User.find(current_user)
  end

  def set_resource_class
  end

  def somebody_set
  end

  def supplier_set
  end
end
