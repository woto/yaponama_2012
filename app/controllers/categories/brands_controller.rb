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
    @spare_infos = @spare_infos.includes(@opt_class.name.demodulize.underscore) if @opt_class
    @spare_infos = @spare_infos.by_brand(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])

    @meta_title = "#{@spare_catalog.name} на #{@brand.name}"
    @meta_title_small = "(рус. #{@brand.brands.slang.pluck(:name).join(', ')})" if @brand.brands.slang.exists?
    @discourse = [@meta_title]
  end

  private

  def find_resource
    @spare_catalog = SpareCatalog.find(params[:category_id])
    if @spare_catalog.opt
      @opt_class = "Opts::#{@spare_catalog.opt.camelize}".constantize
    end
  end


end
