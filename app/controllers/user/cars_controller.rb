class User::CarsController < ApplicationController

  private

  def set_resource_class
    @resource_class = Car
  end

  def new_resource
    @resource = @resource_class.new(vin_or_frame: 'vin')
  end

  def create_resource
    @resource = @resource_class.new(
      resource_params.deep_merge(
        user: current_user,
        creator: current_user,
        brand_attributes: {
          is_brand: '1'}))
  end

  def resource_params
    params.require(:car).permit(
      :vin_or_frame,
      :vin,
      :frame,
      {:brand_attributes => :name},
      {:model_attributes => :name},
      {:generation_attributes => :name},
      {:modification_attributes => :name},
      :notes)
  end
end
