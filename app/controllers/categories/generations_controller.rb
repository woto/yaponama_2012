class Categories::GenerationsController < ApplicationController

  skip_before_action :find_resource

  def show
    @resource = SpareCatalog.find(params[:category_id])

    @generation = Generation.find(params[:id])
    @model = @generation.model
    @brand = @model.brand

    @modifications = SpareApplicability.by_generation(params[:id]).by_category(params[:category_id])
    @parts = SpareInfo.by_generation(params[:id]).by_category(params[:category_id])
  end
end
