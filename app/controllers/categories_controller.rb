class CategoriesController < ApplicationController

  def index
    @categories = SpareInfo.
      joins(:spare_applicabilities).
      order(:cached_spare_catalog).
      select(:spare_catalog_id, :cached_spare_catalog).
      distinct
  end

end
