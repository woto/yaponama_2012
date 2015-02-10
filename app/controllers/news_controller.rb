class NewsController < ApplicationController
  def index
    @news = News.order(date: :desc).page(params[:page]).per(params[:per])
  end

  private

  def set_resource_class
    @resource_class = News
  end

end
