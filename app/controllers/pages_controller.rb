# encoding: utf-8

class PagesController < ApplicationController
  def index
    @page = Page.where(:path => params[:path]).first
    if @page
      @meta_canonical = '/' + params[:path]
      @meta_title = @page.title
      @meta_description = @page.description
      @meta_keywords = @page.keywords
      @meta_robots = @page.robots

      @comments = Comment.where(:commentable_id => @page.id, :commentable_type => @page.class).arrange(:order => :created_at)
      @comment = Comment.new()
      @comment.commentable = @page
      @name = current_user.names.where(:creation_reason => Rails.configuration.user_name_creation_reason['self']).first

    else
      raise ActionController::RoutingError, "Страница #{params[:path]} не существует"
    end
  end
end
