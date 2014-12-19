class Categories::ModificationsController < ApplicationController

  def show
    @modification = Modification.find(params[:id])
    @generation = @modification.generation
    @model = @generation.model
    @brand = @model.brand

    @q = SpareInfo.search(params[:q])
    @parts = @q.result(distinct: true)
    @parts = @parts.by_modification(params[:id]).by_category(params[:category_id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end

  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end

end
