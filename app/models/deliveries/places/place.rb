class Deliveries::Places::Place < ActiveRecord::Base
  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, :reject_if => :all_blank, :allow_destroy => true
  validates :variants, :length => { :minimum => 1 }

  validates :vertices, :presence => true
  validates :z_index, numericality: { only_integer: true }
  validates :name, :variants, :presence => true, if: -> { realize }
  ['active', 'inactive'].each do |style|
    instance_eval do
      ['fill_opacity', 'stroke_opacity', 'stroke_weight'].each do |prop|
        validates "#{style}_#{prop}".to_sym, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }, if: -> { realize }
      end
      ['fill_color', 'stroke_color'].each do |prop|
        validates "#{style}_#{prop}".to_sym, css_hex_color: true, if: -> { realize }
      end
    end
  end

  def prepare

    self.zoom = SiteConfig.initial_map_zoom
    self.lat = SiteConfig.initial_map_lat
    self.lng = SiteConfig.initial_map_lng
    self.z_index = 100

    ['active', 'inactive'].each do |style|
      self["#{style}_fill_color"] = '#000000'
      self["#{style}_fill_opacity"] = '0.5'
      self["#{style}_stroke_color"] = '#000000'
      self["#{style}_stroke_opacity"] = '0.5'
      self["#{style}_stroke_weight"] = '0.5'
    end
  end
end
