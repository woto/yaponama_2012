class Admin::SpareCatalogsController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = SpareCatalog
  end

  def find_resources
    super
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
  end

end
