class CategoriesController < ApplicationController
  skip_before_action :find_resources

  def index

    scgt = SpareCatalogGroup.arel_table
    sct = SpareCatalog.arel_table

    @q = SpareCatalog.search(params[:q])
    @spare_catalogs = @q.result(distinct: true)
    @spare_catalogs = @spare_catalogs.
      select("CONCAT(CONCAT(CASE WHEN spare_catalog_groups.ancestry IS NULL THEN '/' ELSE CONCAT(CONCAT('/', spare_catalog_groups.ancestry), '/') END, spare_catalog_groups.id), '/') as ancestry, spare_catalogs.id, spare_catalogs.name, count(spare_infos.id) as count, LENGTH(spare_catalogs.opt) > 0 special").
      joins(:spare_infos).
      joins(sct.join(scgt, Arel::Nodes::OuterJoin).on(scgt[:id].eq(sct[:spare_catalog_group_id])).join_sources).
      group("spare_catalogs.id, spare_catalog_groups.id, spare_catalog_groups.ancestry").
      order("spare_catalogs.name")

    @meta_title = "Запчасти"
    @discourse = [@meta_title]
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
    @spare_infos = @spare_infos.includes(@opt_class.name.demodulize.underscore) if @opt_class
    @spare_infos = @spare_infos.by_category(params[:id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])

    @meta_title = "#{@spare_catalog.name}"
    @discourse = [@meta_title]
  end

  private

  def find_resource
    @spare_catalog = SpareCatalog.find(params[:id])
    if @spare_catalog.opt
      @opt_class = "Opts::#{@spare_catalog.opt.camelize}".constantize
    end
  end

end
