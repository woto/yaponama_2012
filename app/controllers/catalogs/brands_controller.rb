class Catalogs::BrandsController < ApplicationController

  private

  def find_resource
    @brand = Brand.find(params[:id])
    @models = SpareApplicability.by_brand(params[:id])
    @parts = SpareInfo.by_brand(params[:id])
    @parts = @parts.page(params[:page]).per(params[:per])
  end

end
