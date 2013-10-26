class Admin::BrandsController < ApplicationController
  include Admin::Admined
  include GridBrand
  include GetUserFromResourceDummy

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy, :search]
  skip_before_filter :only_authenticated, :only => :search

  respond_to :json

  def search
    brand_t = Brand.arel_table

    if params[:name].present?
      @resources = Brand.where(brand_t[:name].matches("#{params[:name]}%"))
    end

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end


  private

  def set_user_and_creation_reason
    super
    @resource.phantom = false
  end

end
