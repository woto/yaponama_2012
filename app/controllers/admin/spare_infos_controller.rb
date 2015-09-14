class Admin::SpareInfosController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = SpareInfo
  end

end
