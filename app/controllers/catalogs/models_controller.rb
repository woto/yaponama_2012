class Catalogs::ModelsController < ApplicationController

  private

  def find_resource
    @model = Model.find(params[:id])
    @brand = @model.brand

    @spare_infos = SpareInfo.by_model(params[:id]).by
  end

end
