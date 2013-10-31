# encoding: utf-8

class BrandsController < ApplicationController

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
    @resource = Brand.where(:name => params[:brand]).first
    commentable_helper @resource
  end

  def user_get
  end

  def somebody_get
  end

  def supplier_get
  end

end
