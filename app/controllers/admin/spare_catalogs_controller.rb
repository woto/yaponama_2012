class Admin::SpareCatalogsController < ApplicationController
  include Admin::Admined

  def index
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
    respond_to do |format|
      format.html
    end
  end

  private

  def set_resource_class
    @resource_class = SpareCatalog
  end

end
