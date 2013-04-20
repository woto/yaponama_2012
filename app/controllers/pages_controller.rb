# encoding: utf-8

class PagesController < ApplicationController
  def show
    @page = Page.where(:path => params[:path]).first
    if @page
      @meta_canonical = '/' + params[:path]
      @meta_title = @page.title
      @meta_description = @page.description
      @meta_keywords = @page.keywords
      @meta_robots = @page.robots

      commentable_helper(@page)

    else
      raise ActionController::RoutingError, "Страница #{params[:path]} не существует"
    end
  end

end
