class Progon

  LOGGER = Logger.new(STDOUT)

  def self.progon
    # TODO проверить потом что там с зоной и датой
    #SpareInfo.includes(:spare_info_phrases).where(:spare_info_phrases => {publish: true}).find_each do |spare_info|
    SpareInfo.find_each do |spare_info|
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
