class Categories::ModificationsController < ApplicationController

  def show
    @modification = Modification.find(params[:id])
    @generation = @modification.generation
    @model = @generation.model
    @brand = @model.brand

    @q = SpareInfo.search(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.by_modification(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])
  end

  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end

end
