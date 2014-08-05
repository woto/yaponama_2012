class Catalogs::BrandsController < ApplicationController

  private

  def find_resource
    @brand = Brand.find(params[:id])
    @models = SpareApplicability.by_brand(params[:id])
  end

end
