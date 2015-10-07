class Admin::Deliveries::PlacesController < ApplicationController
  include Admin::Admined

  private

    def new_resource
      super
      @resource.variants.new
      @resource.z_index = 100
    end

  private

  def find_resources
    super
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
  end

  def set_resource_class
    @resource_class = ::Deliveries::Place
  end

end
