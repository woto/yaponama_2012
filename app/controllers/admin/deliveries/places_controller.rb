class Admin::Deliveries::PlacesController < ApplicationController
  include Admin::Admined

  private

    def new_resource
      super
      @resource.variants.new
      @resource.z_index = 100
    end

  private

  def set_resource_class
    @resource_class = ::Deliveries::Place
  end

end
