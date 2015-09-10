class BrandsController < ApplicationController

  skip_before_action :find_resource, :only => :search

  def search
    # TODO Тут не совсем правильно, из-за того что можно создать бесконечную цепочку, а тут только несколько уровней вложения.
    # Плюс ко всему не совсем корректные фильтры. Например набрав 'Toy' можно найти 'Toyota', а должно быть 'Toyota Lexus'

    brand_t = Brand.arel_table

    @resources = Brand
    @resources = Brand.where("brands.brand_id IS NULL OR brands.sign = #{Brand.signs[:conglomerate]}")

    if params[:name].present?
      b = Arel::Table.new Brand.reflect_on_association(:brands)
      b2 = Arel::Table.new Brand.reflect_on_association(:brands)
      b.table_alias = 'brands_brands'
      b2.table_alias = 'brands_brands_2'
      @resources = @resources.where(brand_t[:name]. matches("#{params[:name]}%")
                                    .or(b[:name].matches("#{params[:name]}%"))
                                    .or(b2[:name].matches("#{params[:name]}%")))
        .includes(:brands => :brands)
        .references(:brands_brands)
        .references(:brands_brands_2)
    end

    if params[:is_brand] == '1'
      @resources = @resources.where(is_brand: true)
    else
      #@resources = @resources.where()
    end

    @resources = @resources.order(:name).page params[:page]

    respond_to do |format|
      format.js
      format.json { render json: @resources }
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
