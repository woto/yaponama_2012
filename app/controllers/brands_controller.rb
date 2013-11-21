# encoding: utf-8
#
class BrandsController < ApplicationController


  def search
    brand_t = Brand.arel_table

    @resources = Brand

    if params[:name].present?
      @resources = Brand.where(brand_t[:name].matches("#{params[:name]}%"))
    end

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end



  private

  def set_resource_class
    @resource_class = Brand
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

  def find_resource
    @resource = Brand.where(:name => CGI.unescape(params[:brand])).first
    commentable_helper @resource
  end

  def user_get
  end

  def somebody_get
  end

  def supplier_get
  end

end
