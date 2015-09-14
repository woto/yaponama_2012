class SpareCatalogsController < ApplicationController

  def search
    @q = SpareCatalog.ransack(params[:q])
    @spare_catalogs = @q.result(distinct: true)
    @spare_catalogs = @spare_catalogs.order(:name).page params[:page]

    respond_to do |format|
      format.json {render json: @spare_catalogs}
    end
  end

  private

  def set_resource_class
    @resource_class = SpareCatalog
  end

end
