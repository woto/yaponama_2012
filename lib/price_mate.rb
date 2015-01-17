class PriceMate

  def self.catalog_number catalog_number
    catalog_number.to_s.mb_chars.upcase.gsub(/[^A-Z0-9]/i, '')
  end

  def self.manufacturer manufacturer
    manufacturer.to_s.mb_chars.upcase
  end

  def self.spare_catalog
    SpareCatalog.find_or_create_by(name: 'НЕ РАЗОБРАННЫЕ')
  end

  def self.true_or_false value
    case value
    when nil, false, '0', 0
      '0'
    when true, 1, '1'
      '1'
    end
  end

  def self.sort_by_brand_rating formatted_data
    # TODO Случайно обнаружил, что блок, занимающийся сортировкой брендов по рейтингу я успешно удалил.
    # Вернул. Но этот блок в оригинале сортирует еще и цены. Поэтому немного подредактировал в надежде 
    # на то, что с ценами у меня все нормально (я ранее делал сортировку чтобы наши магазины поднимались наверх)
    formatted_data = formatted_data.map do |catalog_number, cn_scope|
      [ catalog_number, (cn_scope.sort do |a, b|
        k = a[1][:brand]
        l = b[1][:brand]
        -(k.try(:[], :rating).try(:to_i) || 0) <=> -(l.try(:[], :rating).try(:to_i) || 0)
      end)]
    end
    formatted_data
  end

  def self.sort_by_godness parsed_json

    #parsed_json["result_prices"].shuffle!

    parsed_json["result_prices"] =
      parsed_json["result_prices"].sort_by do |a|

        days = (((a["job_import_job_delivery_days_average"].present? ? a["job_import_job_delivery_days_average"] : a["job_import_job_delivery_days_declared"]).to_f + a["job_import_job_delivery_days_declared"].to_f)/2 )
        days/5 +  a["price_goodness"].to_f - a["success_percent"]/10
      end

    parsed_json
  end

  def self.database formatted_data
    formatted_data.each do |catalog_number, cn_scope|
      cn_scope.each do |manufacturer, mf_scope|
        mf_scope[:title] = (mf_scope[:titles].sort_by{|a, b| -b} + ([["", 0]]))[0][0]
        info = SpareInfo.where(:catalog_number => catalog_number, :cached_brand => manufacturer).first

        # Если такой SpareInfo имеется, то все последующие данные получаем через него
        if info.present?
          mf_scope[:info] = info
          catalog = info.spare_catalog
        # Если категория получена с сервера прайсов
        #elsif mf_scope["image_url"].present?
        #  catalog = SpareCatalog.find_by(name: mf_scope["image_url"])
        # Если категори получена из названий
        end

        catalog = SpareCatalog.
          joins(:spare_catalog_tokens).
          where("? LIKE '%' || spare_catalog_tokens.name || '%'", mf_scope[:titles].keys.join(' ')).
          references(:spare_catalog_tokens).group('spare_catalogs.id').
          order('sum(spare_catalog_tokens.weight) DESC').
          select('spare_catalogs.*').
          limit(1).first
        SpareCatalogJob.perform_later(catalog_number, mf_scope[:brand], catalog)
        mf_scope[:catalog] = catalog
      end
    end
    formatted_data
  end

  def self.meta_keywords formatted_data
    keywords = Hash.new {|hash,key| hash[key] = 0}
    formatted_data.map{|k, v| v.map{|kk, vv| vv[:titles].map{|kkk, vvv| kkk}}}.flatten.join(', ').split(/[, ]/).reject{|kkk| kkk.size < 2}.each { |word| keywords[word] += 1 }
    keywords = keywords.sort{|k, v| k[1] <=> v[1]}.reverse
    keywords = keywords[0, (keywords.size/4.0).round]
    keywords.map{|k, v| k}.join(', ')
  end

  def self.meta_title c9, b9, r9, titles, formatted_data
    meta_title = ''
    if r9.present?
      meta_title << "Замены и аналоги #{c9} "
      meta_title << "#{b9} " if b9
    else
      # Каталожник тут всегда будет 1? TODO
      meta_title << formatted_data.map{|k, v| k}.flatten.uniq.reject{|kk| kk.size < 2}[0, 2].join(', ')
      # Производители
      meta_title << " "
      meta_title << formatted_data.map{|k, v| v.map{|kk, vv| kk}}.flatten.uniq.reject{|kk| kk.size < 2}[0, 5].join(', ')
      meta_title << " "
    end
    meta_title << titles[0].to_s.mb_chars.capitalize
    meta_title.truncate(60)
  end

  def self.meta_description titles
    meta_description = ''
    # Названия
    if titles.size > 1
      meta_description << titles[1, 3].join(', ').mb_chars.capitalize
    else
      meta_description << titles[0].to_s.mb_chars.capitalize
    end
    meta_description << ". Удобная оплата. Отправка в регионы, доставка по Москве, самовывоз Рязанский и Ленинградский проспект."
    # /Description
  end


  def self.search catalog_number, manufacturer, replacements, emex, cached
    catalog_number = CGI::escape(PriceMate.catalog_number(catalog_number))
    manufacturer = CGI::escape(PriceMate.manufacturer(manufacturer) || '')
    replacements = true_or_false(replacements)
    emex = "&ext_ws=#{true_or_false(emex)}"
    cached = "&cached=#{true_or_false(cached)}"

    price_request_url = "http://#{Rails.application.config_for('application/price')['host']}:#{Rails.application.config_for('application/price')['port']}/prices/search?catalog_number=#{catalog_number}&manufacturer=#{manufacturer}&replacements=#{replacements}#{emex}&format=json&for_site=1#{cached}"

    parsed_price_request_url = URI.parse(price_request_url)
    resp = Net::HTTP.get_response(parsed_price_request_url)
    ActiveSupport::JSON.decode(resp.body)
  end

  def self.process parsed_json
    counter = Hash.new{|h, k| h[k] = 0}
    formatted_data = {}

    parsed_json["result_prices"].each do |item|

      cn = item["catalog_number"].to_s
      canonical_brand = BrandMate.find_or_create_canonical!(item["manufacturer"])
      mf = canonical_brand.name.to_s

      h = cn + " - " + mf
      counter[h] += 1

      if counter[h] <= 5

        # Если нет такого каталожника, создаем
        unless formatted_data.include?(cn)
          formatted_data[cn] = {}
        end

        # Если нет такого производителя, создаем производителя и внутри него структуру
        unless formatted_data[cn].include? mf

          formatted_data[cn][mf] = {
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

        offer = {
          :country => item["job_import_job_country_short"],
          :min_days => [ item["job_import_job_delivery_days_declared"], item["job_import_job_delivery_days_average"] ].compact.min,
          :max_days => [ item["job_import_job_delivery_days_declared"], item["job_import_job_delivery_days_average"] ].compact.max,
          :probability => item["success_percent"],
          :retail_cost => item["retail_cost"].to_f.round,
          :count => item["count"],
          :title => '',
          :delivery => item["job_import_job_delivery_summary"],
          :income_cost => item["income_cost"].to_f.round,
          :tech => techs.map{|tech| item[tech].to_s}.reject(&:blank?).join(', ')
        }

        formatted_data[cn][mf][:offers].push(offer)

        # Мин. кол-во дней
        comparsion = formatted_data[cn][mf][:min_days].nil? ? [] : [formatted_data[cn][mf][:min_days]]
        comparsion.push offer[:min_days]
        formatted_data[cn][mf][:min_days] = comparsion.min

        # Макс. кол-во дней
        comparsion = formatted_data[cn][mf][:max_days].nil? ? [] : [formatted_data[cn][mf][:max_days]]
        comparsion.push offer[:max_days]
        formatted_data[cn][mf][:max_days] = comparsion.max

        # Мин. цена
        comparsion = formatted_data[cn][mf][:min_cost].nil? ? [] : [formatted_data[cn][mf][:min_cost]]
        comparsion.push offer[:retail_cost]
        formatted_data[cn][mf][:min_cost] = comparsion.min

        # Макс. цена
        comparsion = formatted_data[cn][mf][:max_cost].nil? ? [] : [formatted_data[cn][mf][:max_cost]]
        comparsion.push offer[:retail_cost]
        formatted_data[cn][mf][:max_cost] = comparsion.max

      end

      ["title", "title_en", "description", "applicability", "parts_group"].each do |field_title|
        if item[field_title].present?
          title = item[field_title].to_s.mb_chars.upcase.to_s
          unless formatted_data[cn][mf][:titles][title]
            formatted_data[cn][mf][:titles][title] = 1
          else
            formatted_data[cn][mf][:titles][title] += 1
          end
        end
      end

      manufacturer_orig = item["manufacturer_orig"].to_s.mb_chars.upcase.to_s
      catalog_number_orig = item["catalog_number_orig"].to_s.mb_chars.upcase.to_s
      weight = ((tmp = item["weight_grams"].to_f) > 0 ? ((tmp + 100) / 1000).round(1) : nil)

      # Запоминаем количество повторений одного и того же оригинального написания кат. номера
      if catalog_number_orig.present? && catalog_number_orig != cn
        unless formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig]
          formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig] = 1
        else
          formatted_data[cn][mf][:catalog_number_origs][catalog_number_orig] += 1
        end
      end

      # Запоминаем количество повторений одного и того же оригинального производителя
      if manufacturer_orig.present? && manufacturer_orig != mf
        unless formatted_data[cn][mf][:manufacturer_origs][manufacturer_orig]
          formatted_data[cn][mf][:manufacturer_origs][manufacturer_orig] = 1
        else
          formatted_data[cn][mf][:manufacturer_origs][manufacturer_orig] += 1
        end
      end

      # Запоминаем количество повторений одного и того же веса
      if weight.present?
        unless formatted_data[cn][mf][:weights][weight]
          formatted_data[cn][mf][:weights][weight] = 1
        else
          formatted_data[cn][mf][:weights][weight] += 1
        end
      end

    end

    formatted_data

  end

  def self.clear parsed_json
    #parsed_json.delete("result_replacements")
    parsed_json.delete("result_message")
    parsed_json["result_prices"].each do |item|
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
      item.delete "created_at"
      item.delete "price_setting_id"
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
    parsed_json
  end
end
