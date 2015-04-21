class Progon

  LOGGER = Logger.new(STDOUT)

  # Пустой массив
  # Массив номеров кампаний
  YANDEX_CAMPAIGNS_IDS = []
  # true  - Только наличие
  # false - Все
  ONLY_WAREHOUSES = false
  PUBLISHED_STATUS = []

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

    if ONLY_WAREHOUSES
      spare_infos = spare_infos.joins(:warehouses)
    end

    spare_infos.find_each do |spare_info|
      begin
        LOGGER.info "probing #{spare_info.to_label}"
        open("http://#{Rails.application.config_for('application/site')['host']}:#{Rails.application.config_for('application/site')['port']}/user/products/new?catalog_number=#{spare_info.catalog_number}")
        sleep 0.5
      rescue Exception => e
        sleep 1
        LOGGER.warn e.message
        LOGGER.warn spare_info.catalog_number
      end
    end
  end
end
