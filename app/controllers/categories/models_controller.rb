class Categories::ModelsController < ApplicationController

  skip_before_action :find_resource

  def show
    @resource = SpareCatalog.find(params[:category_id])

    @model = Model.find(params[:id])
    @brand = @model.brand

    @generations = SpareApplicability.by_model(params[:id]).by_category(params[:category_id])
    @parts = SpareInfo.by_model(params[:id]).by_category(params[:category_id])
  end
end
