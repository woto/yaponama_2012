class Admin::SpareInfosController < ApplicationController
  include Admin::Admined

  private

  def find_resources
    super
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
  end

  def set_resource_class
    @resource_class = SpareInfo
  end

end
