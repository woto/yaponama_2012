class Catalogs::GenerationsController < ApplicationController

  private

  def find_resource
    @generation = Generation.find(params[:id])
    @model = @generation.model
    @brand = @model.brand

    @generations = SpareApplicability.by_generation(params[:id])
    @parts = SpareInfo.by_generation(params[:id])
  end

end
