class Catalogs::BrandsController < ApplicationController

  private

  def find_resource
    @brand = Brand.find(params[:id])

    @spare_applicabilities = SpareApplicability.by_brand(params[:id])
  end

end
