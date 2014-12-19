class CategoriesController < ApplicationController

  def index
    @categories = SpareInfo.by
  end

  def show
    @brands = SpareApplicability.by.by_category(params[:id])

    @q = SpareInfo.search(params[:q])
    @parts = @q.result(distinct: true)
    @parts = @parts.by_category(params[:id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end

  private

  def find_resource
    @resource = SpareCatalog.find(params[:id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end


end
