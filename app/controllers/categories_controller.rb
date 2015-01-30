class CategoriesController < ApplicationController

  def index
    @spare_infos = SpareInfo.by
  end

  def show
    @spare_applicabilities = SpareApplicability.by.by_category(params[:id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.by_category(params[:id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])
  end

  private

  def find_resource
    @resource = SpareCatalog.find(params[:id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end


end
