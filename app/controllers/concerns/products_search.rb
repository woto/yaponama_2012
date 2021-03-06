# encoding: utf-8
#
module ProductsSearch

  extend ActiveSupport::Concern

  included do

    private

    def search c9, b9, r9

      @c9 = c9
      @b9 = b9
      @r9 = r9

      @discourse = PriceMate.catalog_number(@c9).downcase

      plog = Logger.new Rails.root.join('log', 'prices.log')
      plog.formatter = Logger::Formatter.new
      plog.debug "-----------------------------"

      @parsed_json = { "result_prices" => [] }

      @meta_title = "Ничего не найдено"

      if c9.present?

        if Rails.configuration.price['request_emex']
          e8 = true
        end

        price_request_cache_key = "#{c9}-#{b9}-#{r9}"

        plog.debug "Проверка наличия кеша"
        if Rails.cache.exist? price_request_cache_key
          @parsed_json = (Rails.cache.read(price_request_cache_key)).dup
          plog.debug "Кеш найден"
        else
          plog.debug "Кеш не найден"

          plog.debug "Запрос к серверу прайсов"
          begin
            @parsed_json = ::PriceMate.search(Rails.configuration.price['host'], Rails.configuration.price['port'], c9, b9, r9, e8, false)
          rescue *[SocketError, JSON::ParserError, Timeout::Error, Errno::ECONNREFUSED] => e
            response.headers["Retry-After"] = (Time.now + 1.day).httpdate.to_s
            render :status => 503 and return
          end
          plog.debug "/Запрос к серверу прайсов"

          plog.debug 'Большой цикл очистки JSON'
          @parsed_json = ::PriceMate.clear(@parsed_json)
          plog.debug '/Большой цикл очистки JSON'

          if r9
            expires_in = Rails.configuration.price['price_request_cache_with_replacements_in_seconds']
          else
            expires_in = Rails.configuration.price['price_request_cache_without_replacements_in_seconds']
          end

          @parsed_json = PriceMate.sort_by_godness @parsed_json

          Rails.cache.write(price_request_cache_key, @parsed_json, :expires_in => expires_in)
          plog.debug 'Кеш записан'
        end

        unless Rails.env.development? || current_user
          require 'digest/md5'
          etag = Digest::MD5.hexdigest(@parsed_json.to_s)
          fresh_when :last_modified => File.mtime(File.join(Rails.root, 'tmp')), :etag => etag
        end

        plog.debug 'Большой цикл обработки JSON'
        @formatted_data = PriceMate.process @parsed_json
        plog.debug '/Большой цикл обработки JSON'

        plog.debug 'Вычищение'
        @formatted_data = PriceMate.cleanup @formatted_data
        plog.debug '/Вычищение'

        @replacements = @parsed_json['result_replacements']

        plog.debug 'Получаем сведения с текущей базы'
        @formatted_data = PriceMate.database @formatted_data
        plog.debug '/Получаем сведения с текущей базы'

        plog.debug 'Получаем сведения о заменах PostgreSQL'
        @formatted_data = PriceMate.replacements @formatted_data
        plog.debug '/Получаем сведения о заменах PostgreSQL'

        plog.debug 'Warehouse'
        @formatted_data = PriceMate.warehouses @formatted_data
        plog.debug '/Warehouse'

        plog.debug 'Сортировка по рейтингам брендов'
        @formatted_data = PriceMate.sort_by_brand_rating @formatted_data
        plog.debug '/Сортировка по рейтингам брендов'
      end

      # TODO переделать через throw или exception ?! (невозможно из метода прекратить выполнение кода контроллера)
      if @formatted_data.blank?
        render :status => 404 and return
      else

        plog.debug 'Заполняем метаданные'


        plog.debug 'Keywords'
        @meta_keywords = PriceMate.meta_keywords @formatted_data
        plog.debug '/Keywords'

        titles = @formatted_data.map{|k, v| v.map{|kk, vv| vv[:titles]}}.map{|kkk| kkk.map{|kkkk| kkkk.to_a}}.flatten(2).sort{|kkkkk, vvvvv| kkkkk[1] <=> vvvvv[1]}.reverse.map{|kkkkk| kkkkk[0]}.uniq

        plog.debug 'Title'
        @meta_title = PriceMate.meta_title c9, b9, r9, titles, @formatted_data
        plog.debug '/Title'


        plog.debug 'History'
          unless r9
            session[:history] ||= []
            session[:history] |= [[c9, @meta_title]]
            session[:history].pop if session[:history].size > 10
          end
        plog.debug '/History'


        plog.debug 'Description'
        @meta_description = PriceMate.meta_description titles
        plog.debug '/Description'

        plog.debug 'Canonical'
        @meta_canonical = new_user_product_url(catalog_number: c9, replacements: r9)
        plog.debug '/Canonical'

        plog.debug 'Robots'
        if @replacements.map{|obj| obj['catalog_number']}.uniq.length <= 1 && r9
          @meta_robots = 'noindex, nofollow'
        end
        plog.debug '/Robots'

        plog.debug '/Заполняем метаданные'

      end

      true
    end


  end

end
