# encoding: utf-8
#
class CarsController < ProfileablesController
  include Grid::Car

  def new_resource
    @resource = @resource_class.new(vin_or_frame: 'vin')
  end

  private

  def set_resource_class
    @resource_class = Car
  end

end
