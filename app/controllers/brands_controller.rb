class BrandsController < ApplicationController

  respond_to :json, :js

  skip_before_filter :only_authenticated, :only => :search
  skip_before_action :find_resource, :only => :search

  def search
    brand_t = Brand.arel_table

    @resources = Brand.where(brand_id: nil)

    if params[:name].present?
      b = Arel::Table.new Brand.reflect_on_association(:brands)
      b.table_alias = 'brands_brands'
      @resources = @resources.where(brand_t[:name]. matches("#{params[:name]}%")
                                    .or(b[:name].matches("#{params[:name]}%")))
        .includes(:brands)
        .references(:brands_brands)
    end

    if params[:is_brand]
      @resources = @resources.where(is_brand: true)
    end

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end

  private

  def set_resource_class
    @resource_class = Brand
  end

end
