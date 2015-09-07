class User::CarsController < ApplicationController

  private

  def set_resource_class
    @resource_class = User::Car
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

end
