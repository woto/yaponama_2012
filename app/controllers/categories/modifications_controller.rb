class Categories::ModificationsController < ApplicationController

  def show
    @modification = Modification.find(params[:id])
    @generation = @modification.generation
    @model = @generation.model
    @brand = @model.brand

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.includes(@opt_class.name.demodulize.underscore) if @opt_class
    @spare_infos = @spare_infos.by_modification(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])

    @meta_title = "#{@spare_catalog.name} на #{@brand.name} #{@model.name} #{@generation.name} #{@modification.name}"
    @discourse = [@meta_title]
  end

  def find_resource
    @spare_catalog = SpareCatalog.find(params[:category_id])
    if @spare_catalog.opt
      @opt_class = "Opts::#{@spare_catalog.opt.camelize}".constantize
    end
  end

end
