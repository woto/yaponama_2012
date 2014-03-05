class SpareCatalogsController < ApplicationController
  include GridSpareCatalog
  skip_before_filter :set_grid

  private
  def set_resource_class
    @resource_class = SpareCatalog
  end

end