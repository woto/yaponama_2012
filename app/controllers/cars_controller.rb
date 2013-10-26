class CarsController < ProfileablesController
  include GridCar

  def new_resource
    @resource = @resource_class.new(vin_or_frame: 'vin')
  end

end
