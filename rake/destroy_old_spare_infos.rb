class DestroyOldSpareInfos

  LOGGER = Logger.new(STDOUT)

  def self.destroy_old_spare_infos
    SpareInfo.find_each do |spare_info|
      #LOGGER.info "probing #{spare_info.to_label}"
      #TODO обуздать spare_info.cached_brand
      result = PriceMate.search(spare_info.catalog_number, spare_info.cached_brand, false, false, true)
      if result['result_prices'].size <= 5
        LOGGER.info "destory #{spare_info.to_label}"
        #spare_info.destroy
      end
    end
  end
end
