class CatalogsController < ApplicationController
  skip_before_action :find_resource

  def show
    @spare_applicabilities = SpareApplicability.by
  end
end
