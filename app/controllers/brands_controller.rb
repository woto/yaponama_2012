class BrandsController < ApplicationController

  respond_to :json, :js

  skip_before_filter :only_authenticated, :only => :search
  skip_before_action :find_resource, :only => :search

  def search
    brand_t = Brand.arel_table

    @resources = Brand

    if params[:name].present?
      @resources = Brand.where(brand_t[:name].matches("#{params[:name]}%"))
    end

    @resources = @resources.where(is_brand: true)

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end

  private

  def set_resource_class
    @resource_class = Brand
  end

end
