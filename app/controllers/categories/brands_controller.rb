class Categories::BrandsController < ApplicationController

  def show
    @brand = Brand.find(params[:id])

    @models = Model.
      where(brand_id: params[:id].to_i).
      joins(:spare_applicabilities).
      order('models.name').
      where("spare_applicabilities.model_id IS NOT NULL").
      select("models.id, models.name, count(spare_applicabilities.id) as count").
      group("models.id").
      by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.includes(@resource_class.name.demodulize.underscore) if @resource_class
    @spare_infos = @spare_infos.by_brand(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])

    @meta_title = "#{@resource.name} на #{@brand.name}"
    @meta_title_small = "(рус. #{@brand.brands.slang.pluck(:name).join(', ')})" if @brand.brands.slang.exists?
    @discourse = [@meta_title]
  end

  private

  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end


end
