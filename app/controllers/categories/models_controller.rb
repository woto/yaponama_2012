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
    @spare_infos = @spare_infos.includes(@resource_class.name.demodulize.underscore) if @resource_class
    @spare_infos = @spare_infos.by_model(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])
  end


  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end

end
