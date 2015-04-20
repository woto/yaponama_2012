class Catalogs::ModelsController < ApplicationController

  def show
    @spare_catalogs = SpareCatalog.
      joins(:spare_infos => :spare_applicabilities).
      where(:spare_applicabilities => {:model_id => params[:id].to_i}).
      select("spare_catalogs.id, spare_catalogs.name, count(spare_infos.id) as count").
      order("spare_catalogs.name").
      group("spare_catalogs.id")
  end

  private
 

  def find_resource
    @model = Model.find(params[:id])
    @brand = @model.brand
  end

end
