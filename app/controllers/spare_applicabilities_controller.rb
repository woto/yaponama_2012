class SpareApplicabilitiesController < ApplicationController
  include Grid::SpareApplicability

  private

  def set_resource_class
    @resource_class = SpareApplicability
  end

end
