require 'timeout'

class PriceMate

  def self.catalog_number catalog_number
    catalog_number.to_s.mb_chars.upcase.gsub(/[^А-ЯA-Z0-9]/i, '')
  end

  def self.manufacturer manufacturer
    manufacturer.to_s.mb_chars.upcase
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
        #binding.pry
        a["price_goodness"].to_f + days/90.0 - a["success_percent"]/200.0

      end

    parsed_json
  end

  def self.find_a_category(titles)
    SpareCatalog.
      select('spare_catalogs.*').
      joins(:spare_catalog_tokens).
      references(:spare_catalog_tokens).
      where("? SIMILAR TO spare_catalog_tokens.name", titles).
      group('spare_catalogs.id').
      order('sum(spare_catalog_tokens.weight) DESC').
      limit(1).first || Defaults.spare_catalog
  end

  def self.replacements(formatted_data)
    formatted_data.each do |catalog_number, cn_scope|
      cn_scope.each do |manufacturer, mf_scope|

        mf_scope[:replacements] = {
          new_num_from: [],
          new_num_to: [],
          same_num_from: [],
          same_num_to: [],
          repl_num_from: [],
          repl_num_to: [],
          part_num_from: [],
          part_num_to: []
        }

        if mf_scope[:info].present?
          from = mf_scope[:info].from_spare_replacements.where(wrong: false)
          to =  mf_scope[:info].to_spare_replacements.where(wrong: false)

          to.each do |replacement|
            case replacement.status
            when 'new_num'
              mf_scope[:replacements][:new_num_from] << replacement.from_spare_info
            when 'same_num'
              mf_scope[:replacements][:same_num_from] << replacement.from_spare_info
            when 'repl_num'
              mf_scope[:replacements][:repl_num_from] << replacement.from_spare_info
            when 'part_num'
              mf_scope[:replacements][:part_num_from] << replacement.from_spare_info
            end
          end

          from.each do |replacement|
            case replacement.status
            when 'new_num'
              mf_scope[:replacements][:new_num_to] << replacement.to_spare_info
            when 'same_num'
              mf_scope[:replacements][:same_num_to] << replacement.to_spare_info
            when 'repl_num'
              mf_scope[:replacements][:repl_num_to] << replacement.to_spare_info
            when 'part_num'
              mf_scope[:replacements][:part_num_to] << replacement.to_spare_info
            end
          end
        end
      end
    end
  end

  def self.database formatted_data
    formatted_data.each do |catalog_number, cn_scope|
      cn_scope.each do |manufacturer, mf_scope|
        mf_scope[:title] = (mf_scope[:titles].sort_by{|a, b| -b} + ([["", 0]]))[0][0]
        info = SpareInfo.find_by(:catalog_number => catalog_number, :brand_id => mf_scope[:brand].id)

        if info.present?
          mf_scope[:info] = info
          catalog = info.spare_catalog

          mf_scope[:keyword] = info.spare_info_phrase.catalog_number
          mf_scope[:phrases] = info.spare_info_phrases
        else
          mf_scope[:keyword] = catalog_number
          mf_scope[:phrases] = []
        end

        if info.blank? || ( info.present? && !info.fix_spare_catalog )
          catalog = find_a_category(mf_scope[:titles].keys.join(' '))
        end

        if info.present?
          SpareInfoJob.perform_later(info, catalog, mf_scope[:catalog_number_origs].keys, mf_scope[:titles].keys, mf_scope[:min_days], mf_scope[:min_cost], mf_scope[:offers].size)
        end

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
      # meta_title << formatted_data.map{|k, v| k}.flatten.uniq.reject{|kk| kk.size < 2}[0, 2].join(', ')
      meta_title << formatted_data.map{|k, v| v.map{|kk, vv| vv[:keyword]}}.flatten.uniq.reject{|kk| kk.size < 2}[0, 2].join(', ')
      # Производители
      meta_title << " "
      meta_title << formatted_data.map{|k, v| v.map{|kk, vv| kk}}.flatten.uniq.reject{|kk| kk.size < 2}[0, 5].join(', ')
      meta_title << " "
    end
    meta_title << titles[0].to_s.mb_chars.capitalize
    meta_title.truncate(55)
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


  def self.search host, port, catalog_number, manufacturer, replacements, emex, cached
    status = Timeout::timeout(5) {
      catalog_number = CGI::escape(PriceMate.catalog_number(catalog_number))
      manufacturer = CGI::escape(PriceMate.manufacturer(manufacturer) || '')
      replacements = true_or_false(replacements)
      emex = "&ext_ws=#{true_or_false(emex)}"
      cached = "&cached=#{true_or_false(cached)}"

      price_request_url = "http://#{host}:#{port}/prices/search?catalog_number=#{catalog_number}&manufacturer=#{manufacturer}&replacements=#{replacements}#{emex}&format=json&for_site=1#{cached}"

      parsed_price_request_url = URI.parse(price_request_url)
      resp = Net::HTTP.get_response(parsed_price_request_url)
      ActiveSupport::JSON.decode(resp.body)
    }
  end

  def self.process parsed_json
    counter = Hash.new{|h, k| h[k] = 0}
    formatted_data = {}

    parsed_json["result_prices"].each do |item|

      cn = item["catalog_number"].to_s
      brand = BrandMate.find_or_create_conglomerate item["manufacturer"]

      h = cn + " - " + brand.name
      counter[h] += 1

      if counter[h] <= 5
        formatted_data = prepare_structure(cn, brand, formatted_data)
        offer = fill_offer(item)

        if offer[:probability] > 0
      manufacturer_orig = item["manufacturer_orig"].to_s.mb_chars.upcase.to_s
      catalog_number_orig = item["catalog_number_orig"].to_s.mb_chars.upcase.to_s
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
          formatted_data[cn][brand.name][:offers].push(offer)
          formatted_data[cn][brand.name][:min_days] = min_days(formatted_data[cn][brand.name], offer)
          formatted_data[cn][brand.name][:max_days] = max_days(formatted_data[cn][brand.name], offer)
          formatted_data[cn][brand.name][:min_cost] = min_cost(formatted_data[cn][brand.name], offer)
          formatted_data[cn][brand.name][:max_cost] = max_cost(formatted_data[cn][brand.name], offer)
        end
      end

      formatted_data[cn][brand.name][:titles] = fill_titles(formatted_data[cn][brand.name], item)
      formatted_data[cn][brand.name][:weights] = weights(formatted_data[cn][brand.name], item)
    end

    formatted_data

  end

    formatted_data.each do |catalog_number, cn_scope|
      cn_scope.each do |manufacturer, mf_scope|
        formatted_data[catalog_number].delete(manufacturer) unless mf_scope[:offers].any?
      end
      formatted_data.delete(catalog_number) unless cn_scope.any?
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

  def self.prepare_structure cn, brand, formatted_data

    # Если нет такого каталожника, создаем
    unless formatted_data.include?(cn)
      formatted_data[cn] = {}
    end

    # Если нет такого производителя, создаем производителя и внутри него структуру
    unless formatted_data[cn].include? brand.name

      formatted_data[cn][brand.name] = {
        :titles => {},
        :manufacturer_origs => {},
        :catalog_number_origs => {},
        :weights => {},
        #:min_days => nil,
        #:max_days => nil,
        #:min_cost => nil,
        #:max_cost => nil,
        :offers => [],
        :brand => brand,
        # image_url у всех одинаковый по определению, т.к. берется из price_catalogs
        # несмотря на то, что на сервере прайсов заполняется по образу weights
        #:image_url => item["image_url"]
      }
    end

    formatted_data

  end

  # Мин. кол-во дней
  def self.min_days(data, offer)
    comparsion = data[:min_days].nil? ? [] : [data[:min_days]]
    comparsion.push offer[:min_days]
    comparsion.min
  end
  
  # Макс. кол-во дней
  def self.max_days(data, offer)
    comparsion = data[:max_days].nil? ? [] : [data[:max_days]]
    comparsion.push offer[:max_days]
    comparsion.max
  end

  # Мин. цена
  def self.min_cost(data, offer)
    comparsion = data[:min_cost].nil? ? [] : [data[:min_cost]]
    comparsion.push offer[:retail_cost]
    comparsion.min
  end

  # Макс. цена
  def self.max_cost(data, offer)
    comparsion = data[:max_cost].nil? ? [] : [data[:max_cost]]
    comparsion.push offer[:retail_cost]
    comparsion.max
  end

  def self.fill_titles(data, item)
    ["title", "title_en", "description", "applicability", "parts_group"].each do |field_title|
      if item[field_title].present?
        title = item[field_title].to_s.mb_chars.upcase.to_s
        unless data[:titles][title]
          data[:titles][title] = 1
        else
          data[:titles][title] += 1
        end
      end
    end
    data[:titles]
  end



  # Запоминаем количество повторений одного и того же веса
  def self.weights(data, item)
    data[:weights] = {} unless data.key?(:weights)
    weight = item["weight_grams"].to_f
    weight = weight > 0 ? (weight / 1000).round(1) : nil

    if weight.present?
      unless data[:weights][weight]
        data[:weights][weight] = 1
      else
        data[:weights][weight] += 1
      end
    end
    data[:weights]
  end

  def self.fill_offer(item)
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
      :supplier_id => item["supplier_id"],
      :price_setting_id => item["price_setting_id"],
      :tech => techs.map{|tech| item[tech].to_s}.reject(&:blank?).join(', ')
    }
  end

end
