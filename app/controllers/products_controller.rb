class ProductsController < ApplicationController

  include ProductsSearch

  def new
    respond_to do |format|
      format.html do
        search params[:catalog_number], params[:manufacturer], params[:replacements]
      end
    end
  end

  def create
    respond_to do |format|
      format.js do
        if @resource.save
          render 'create'
        end
      end
    end
  end

  private

  def set_resource_class
    @resource_class = Product
  end

end
