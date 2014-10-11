class SpareCatalogsController < ApplicationController
  include Grid::SpareCatalog

  private

  def set_resource_class
    @resource_class = SpareCatalog
  end

end
