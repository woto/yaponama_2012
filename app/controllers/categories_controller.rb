class CategoriesController < ApplicationController

  def index
    @q = SpareCatalog.search(params[:q])
    @spare_catalogs = @q.result(distinct: true)
    @spare_catalogs = @spare_catalogs.
      joins(:spare_infos => :spare_applicabilities).
      select("spare_catalogs.id, spare_catalogs.name, count(spare_infos.id) as count").
      order("spare_catalogs.name").
      group("spare_catalogs.id")
  end

  def show
    @brands = Brand.
      joins(:spare_applicabilities).
      order("brands.name").
      where("spare_applicabilities.brand_id IS NOT NULL").
      select("brands.id, brands.name, count(spare_applicabilities.id) as count").
      group("brands.id").
      by_category(params[:id])

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
