class Categories::ModelsController < ApplicationController

  def show
    @model = Model.find(params[:id])
    @brand = @model.brand

    @generations = SpareApplicability.by_model(params[:id]).by_category(params[:category_id])

    @q = SpareInfo.search(params[:q])
    @parts = @q.result(distinct: true)
    @parts = @parts.by_model(params[:id]).by_category(params[:category_id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end


  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end

end
