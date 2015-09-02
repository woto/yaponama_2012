class Progon

  LOGGER = Logger.new(STDOUT)

  YANDEX_CAMPAIGNS_IDS = []
  ONLY_WAREHOUSES = false
  PUBLISHED_STATUS = []
  SPARE_CATALOG_IDS = []

  def self.progon
    spare_infos = SpareInfo.
      includes(:spare_info_phrases).
      distinct

    if PUBLISHED_STATUS.any?
      spare_infos = spare_infos.where(:spare_info_phrases => { :publish => PUBLISHED_STATUS })
    end

    if YANDEX_CAMPAIGNS_IDS.any?
      spare_infos = spare_infos.where(:spare_info_phrases => {:yandex_campaign_id => YANDEX_CAMPAIGNS_IDS})
    end

    if SPARE_CATALOG_IDS.any?
      spare_infos = spare_infos.where(:spare_catalog_id => SPARE_CATALOG_IDS)
    end

    if ONLY_WAREHOUSES
      spare_infos = spare_infos.joins(:warehouses)
    end

    spare_infos.find_each do |spare_info|
      begin
        LOGGER.info "probing #{spare_info.to_label}"
        open("http://#{Rails.configuration.site['host']}:#{Rails.configuration.site['port']}/user/products/new?catalog_number=#{spare_info.catalog_number}")
        spare_info.update_column(:aggregated_content_checked_at, Time.zone.now)
        sleep 0.5
      rescue Exception => e
        sleep 1
        LOGGER.warn e.message
        LOGGER.warn spare_info.catalog_number
      end
    end
  end
end
