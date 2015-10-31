class Categories::ModelsController < ApplicationController

  def show
    @model = Model.find(params[:id])
    @brand = @model.brand

    @generations = Generation.
      where(model_id: params[:id].to_i).
      joins(:spare_applicabilities).
      order('generations.name').
      where("spare_applicabilities.generation_id IS NOT NULL").
      select("generations.id, generations.name, count(spare_applicabilities.id) as count").
      group("generations.id").
      by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.includes(@opt_class.name.demodulize.underscore) if @opt_class
    @spare_infos = @spare_infos.by_model(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])

    @meta_title = "#{@spare_catalog.name} на #{@brand.name} #{@model.name}"
    @meta_title_small = "(рус. #{@model.slang})" if @model.slang.present?
    @discourse = [@meta_title]
  end

  def find_resource
    @spare_catalog = SpareCatalog.find(params[:category_id])
    if @spare_catalog.opt
      @opt_class = "Opts::#{@spare_catalog.opt.camelize}".constantize
    end
  end

end
