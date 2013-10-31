# encoding: utf-8

class PagesController < ApplicationController
  include GridPage

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  def show
    if @resource
      @meta_title = @resource.title
      @meta_canonical = '/' + @resource.path
      @meta_description = @resource.description
      @meta_keywords = @resource.keywords
      @meta_robots = @resource.robots

      commentable_helper(@resource)

    else
      raise ActionController::RoutingError, "Страница #{params[:path]} не существует"
    end
  end

  def find_resource
    @resource = @resource_class.where(:path => params[:path]).first
  end

  private

  def set_resource_class
    @resource_class = Page
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

end
