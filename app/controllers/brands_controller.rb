class BrandsController < ApplicationController

  def search
    @q = Brand.ransack(params[:q])
    @brands = @q.result(distinct: true)
    @brands = @brands.order(:name).page params[:page]

    @brands = case params[:manufacturer]
    when '1'
      @brands.where(is_brand: true)
    when '0'
      @brands.where(sign: nil, brand_id: nil)
    end

    respond_to do |format|
      format.js {render 'welcome/search'}
      format.json {render json: @brands}
    end
  end

  def index
    @brands = Brand.
      joins(:spare_infos).
      select("brands.id, brands.name, brands.image, count(spare_infos.id) as count").
      order("brands.name").
      group("brands.id, brands.name")
    @meta_title = 'Бренды'
    @discourse = [@meta_title]
  end

  def show

    scgt = SpareCatalogGroup.arel_table
    sct = SpareCatalog.arel_table

    @brand = Brand.find(params[:id])
    @spare_catalogs = SpareCatalog.
      select("CONCAT(CONCAT(CASE WHEN spare_catalog_groups.ancestry IS NULL THEN '/' ELSE CONCAT(CONCAT('/', spare_catalog_groups.ancestry), '/') END, spare_catalog_groups.id), '/') as ancestry, spare_catalogs.id, spare_catalogs.name, count(spare_infos.id) as count, LENGTH(spare_catalogs.opt) > 0 special").
      joins(:spare_infos).
      joins(sct.join(scgt, Arel::Nodes::OuterJoin).on(scgt[:id].eq(sct[:spare_catalog_group_id])).join_sources).
      where(:spare_infos => {:brand_id => params[:id]}).
      group("spare_catalogs.id, spare_catalog_groups.id, spare_catalog_groups.ancestry").
      order("spare_catalogs.name")

    @meta_title = "Производитель запчастей #{@brand.name}"
    @meta_title_small = "(рус. #{@brand.brands.slang.pluck(:name).join(', ')})" if @brand.brands.slang.exists?
    @discourse = [@meta_title]
  end

  private

  def set_resource_class
    @resource_class = Brand
  end

end
