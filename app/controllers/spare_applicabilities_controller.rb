class SpareApplicabilitiesController < ApplicationController

  private

  def new_resource
    @resource = SpareApplicability.new(
      spare_info: SpareInfo.new,
      brand: Brand.new,
      model: Model.new,
      generation: Generation.new,
      modification: Modification.new)
  end

  def set_resource_class
    @resource_class = SpareApplicability
  end

end
