class Categories::GenerationsController < ApplicationController

  def show
    @generation = Generation.find(params[:id])
    @model = @generation.model
    @brand = @model.brand

    @spare_applicabilities = SpareApplicability.by_generation(params[:id]).by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.by_generation(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])
  end

  private

  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end

end
