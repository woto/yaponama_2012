class Admin::SpareCatalogsController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = SpareCatalog
  end

end
