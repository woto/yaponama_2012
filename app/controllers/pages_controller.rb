# encoding: utf-8
#
class PagesController < ApplicationController
  include GridPage

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  # TODO Не забыть вернуть!
  skip_before_action :verify_authenticity_token

  def show
    @meta_title = @resource.title
    @meta_canonical = '/' + @resource.path
    @meta_description = @resource.description
    @meta_keywords = @resource.keywords
    @meta_robots = @resource.robots
  end

  private

  def find_resource
    path = request.original_fullpath
    path[0] = ''
    @resource = @resource_class.where(:path => CGI::unescape(path)).first
  end

  def set_resource_class
    @resource_class = Page
  end

end
