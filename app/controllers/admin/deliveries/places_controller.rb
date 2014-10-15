class Admin::Deliveries::PlacesController < Deliveries::PlacesController
  include Grid::Place
  include Admin::Admined

  private

    def new_resource
      super

      @resource.variants.new

      @resource.zoom = Rails.application.config_for('application/map')['initial_zoom']
      @resource.lat = Rails.application.config_for('application/map')['initial_lat']
      @resource.lng = Rails.application.config_for('application/map')['initial_lng']
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
