class Categories::BrandsController < ApplicationController

  def show
    @brand = Brand.find(params[:id])

    @spare_applicabilities = SpareApplicability.by_brand(params[:id]).by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.by_brand(params[:id]).by_category(params[:category_id])
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
