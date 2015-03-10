class DestroyOldSpareInfos

  LOGGER = Logger.new(STDOUT)

  def self.destroy_old_spare_infos
    SpareInfo.find_each do |spare_info|
      LOGGER.info "probing #{spare_info.to_label}"
      #TODO обуздать spare_info.cached_brand
      begin
        result = PriceMate.search(spare_info.catalog_number, nil, false, false, true)
        if (result['result_prices'].select{|item| item['success_percent'] > 0}.size < 1) && (spare_info.shows.to_i <= 0)
          LOGGER.info "destory #{spare_info.to_label}, shows: #{spare_info.shows}"
          spare_info.destroy
        end
        sleep 1
      rescue Exception => e
        puts e.message
        sleep 10
      end
    end
  end
end
