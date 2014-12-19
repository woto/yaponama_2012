class Categories::BrandsController < ApplicationController

  def show
    @brand = Brand.find(params[:id])

    @models = SpareApplicability.by_brand(params[:id]).by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @parts = @q.result(distinct: true)
    @parts = @parts.by_brand(params[:id]).by_category(params[:category_id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end

  private

  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end


end
