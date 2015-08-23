class CategoriesController < ApplicationController

  def index

    scgt = SpareCatalogGroup.arel_table
    sct = SpareCatalog.arel_table

    @q = SpareCatalog.search(params[:q])
    @spare_catalogs = @q.result(distinct: true)
    @spare_catalogs = @spare_catalogs.
      joins(:spare_infos).
      joins(sct.join(scgt, Arel::Nodes::OuterJoin).on(scgt[:id].eq(sct[:spare_catalog_group_id])).join_sources).
      select("CONCAT(CONCAT(CASE WHEN spare_catalog_groups.ancestry IS NULL THEN '/' ELSE CONCAT(CONCAT('/', spare_catalog_groups.ancestry), '/') END, spare_catalog_groups.id), '/') as ancestry, spare_catalogs.id, spare_catalogs.name, count(spare_infos.id) as count, LENGTH(spare_catalogs.opt) > 0 special").
      order("spare_catalogs.name").
      group("spare_catalogs.id, spare_catalog_groups.id, spare_catalog_groups.ancestry")
  end

  def show
    @brands = Brand.
      order("brands.name").
      where("spare_applicabilities.brand_id IS NOT NULL").
      select("brands.id, brands.name, count(spare_applicabilities.id) as count").
      group("brands.id").
      by_category(params[:id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.includes(@resource_class.name.demodulize.underscore) if @resource_class
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
