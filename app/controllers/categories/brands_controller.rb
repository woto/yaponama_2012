class Categories::BrandsController < ApplicationController

  skip_before_action :find_resource

  def index
    @resource = SpareCatalog.find(params[:category_id])
    @brands = SpareApplicability.by.by_category(params[:category_id])
  end

  def show
    @resource = SpareCatalog.find(params[:category_id])
    @brand = Brand.find(params[:id])
    @models = SpareApplicability.by_brand(params[:id]).by_category(params[:category_id])
  end

end
