module DefaultTimeZone

  extend ActiveSupport::Concern

  included do

    validate :write_default_russian_time_zone_auto_id_if_wrong

    def write_default_russian_time_zone_auto_id_if_wrong
      unless Rails.configuration.russian_time_zones.keys.map(&:to_i).include? cached_russian_time_zone_auto_id
        self.cached_russian_time_zone_auto_id = SiteConfig.default_time_zone_id
      end
    end

  end

end
