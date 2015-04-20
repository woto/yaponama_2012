class BrandsController < ApplicationController

  skip_before_filter :only_authenticated, :only => :search
  skip_before_action :find_resource, :only => :search

  def search
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
      @resources = @resources.where()
    end

    @resources = @resources.order(:name).page params[:page]

    respond_to do |format|
      format.js
      format.json { render json: @resources }
    end
  end

  def index
    @brands = Brand.
      joins(:spare_infos => :spare_applicabilities).
      select("brands.id, brands.name, brands.image, count(spare_infos.id) as count").
      order("brands.name").
      group("brands.id, brands.name")
  end

  def show
    @brand = Brand.find(params[:id])
    @spare_infos = @brand.spare_infos.by
  end

  private

  def set_resource_class
    @resource_class = Brand
  end

end
