class Catalogs::BrandsController < ApplicationController

  private

  def find_resource
    @brand = Brand.find(params[:id])
    @brands = SpareApplicability.by_brand(params[:id])
  end

end
