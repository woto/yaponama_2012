class Categories::ModificationsController < ApplicationController

  skip_before_action :find_resource

  def show
    @resource = SpareCatalog.find(params[:category_id])

    @modification = Modification.find(params[:id])
    @generation = @modification.generation
    @model = @generation.model
    @brand = @model.brand

    @parts = SpareInfo.by_modification(params[:id]).by_category(params[:category_id])
  end

end
