# encoding: utf-8
#
class Stat < ActiveRecord::Base
  belongs_to :somebody, inverse_of: :stats, counter_cache: true

  after_create do
    h = {}
    h[:cached_location] = location
    h[:cached_title] = title
    h[:cached_referrer] = referrer
    h[:cached_client_width] = client_width
    h[:cached_client_height] = client_height
    h[:cached_screen_width] = screen_width
    h[:cached_screen_height] = screen_height
    h[:cached_russian_time_zone_auto_id] = russian_time_zone_auto_id

    somebody.update_columns(h)
  end

end
