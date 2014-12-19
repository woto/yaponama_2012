class Catalogs::ModificationsController < ApplicationController

  private

  def find_resource
    @modification = Modification.find(params[:id])
    @generation = @modification.generation
    @model = @generation.model
    @brand = @model.brand

    @parts = SpareInfo.by_modification(params[:id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end

end
