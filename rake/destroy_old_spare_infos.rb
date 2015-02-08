class DestroyOldSpareInfos
  def self.destroy_old_spare_infos
    logger = Logger.new(STDOUT)
    SpareInfo.find_each do |spare_info|
      logger.info "probing #{spare_info.to_label}"
      result = PriceMate.search(spare_info.catalog_number, nil, false, false, true)
      if result['result_prices'].size < 2
        logger.info "destory #{spare_info.to_label}"
        spare_info.destroy
      end
    end
  end
end
