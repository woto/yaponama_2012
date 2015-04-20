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
    @spare_infos = @spare_infos.by_generation(params[:id]).by_category(params[:category_id])
    @spare_infos = @spare_infos.page(params[:page]).per(params[:per])
  end

  private

  def find_resource
    @resource = SpareCatalog.find(params[:category_id])
    if @resource.opt
      @resource_class = "Opts::#{@resource.opt.camelize}".constantize
    end
  end

end
