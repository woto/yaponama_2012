class Catalogs::ModelsController < ApplicationController

  private

  def find_resource
    @model = Model.find(params[:id])
    @brand = @model.brand

    @generations = SpareApplicability.by_model(params[:id])
    @parts = SpareInfo.by_model(params[:id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end

end
