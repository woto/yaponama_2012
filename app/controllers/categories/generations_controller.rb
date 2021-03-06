class Categories::GenerationsController < ApplicationController

  def show
    @generation = Generation.find(params[:id])
    @model = @generation.model
    @brand = @model.brand

    @modifications = Modification.
      where(generation_id: params[:id].to_i).
      joins(:spare_applicabilities).
      order('modifications.name').
      where("spare_applicabilities.modification_id IS NOT NULL").
      select("modifications.id, modifications.name, count(spare_applicabilities.id) as count").
      group("modifications.id").
      by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.includes(@opt_class.name.demodulize.underscore) if @opt_class
    @spare_infos = @spare_infos.by_generation(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])

    @meta_title = "#{@spare_catalog.name} на #{@brand.name} #{@model.name} #{@generation.name}"
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
