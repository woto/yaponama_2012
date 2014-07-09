# encoding: utf-8
#
class Admin::Deliveries::PlacesController < Deliveries::PlacesController
  include Admin::Admined
  include GridPlace

  skip_before_filter :set_grid, :only => [:edit, :update, :new, :create, :show, :destroy]

  private

    def new_resource
      super

      @resource.variants.new

      @resource.zoom = CONFIG.map['initial_zoom']
      @resource.lat = CONFIG.map['initial_lat']
      @resource.lng = CONFIG.map['initial_lng']
      @resource.z_index = 100

      ['active', 'inactive'].each do |style|
        @resource["#{style}_fill_color"] = '#000000'
        @resource["#{style}_fill_opacity"] = '0.5'
        @resource["#{style}_stroke_color"] = '#000000'
        @resource["#{style}_stroke_opacity"] = '0.5'
        @resource["#{style}_stroke_weight"] = '0.5'
      end

    end

  private

  def set_resource_class
    @resource_class = Deliveries::Place
  end

end
