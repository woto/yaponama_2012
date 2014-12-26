class NewsController < ApplicationController
  def index
    @news = News.order(date: :desc).page(params[:page])
  end

  private

  def set_resource_class
    @resource_class = News
  end

end
