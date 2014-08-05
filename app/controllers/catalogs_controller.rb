class CatalogsController < ApplicationController
  skip_before_action :find_resource

  def show
    @brands = SpareApplicability.by
  end
end
