class Admin::SpareCatalogsController < ApplicationController
  include Admin::Admined

  def index
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
  end

  private

  def set_resource_class
    @resource_class = SpareCatalog
  end

end
