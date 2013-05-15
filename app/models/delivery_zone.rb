class DeliveryZone < ActiveRecord::Base

  validates :name, :presence => true

  def prepare

    self.zoom = SiteConfig.initial_map_zoom
    self.lat = SiteConfig.initial_map_lat
    self.lng = SiteConfig.initial_map_lng
    self.z_index = 100

    ['active', 'inactive'].each do |style|
      self["#{style}_fill_color"] = 'black'
      self["#{style}_fill_opacity"] = '0.5'
      self["#{style}_stroke_color"] = 'black'
      self["#{style}_stroke_opacity"] = '0.5'
      self["#{style}_stroke_weight"] = '0.5'
    end
  end
end
