class NewsController < ApplicationController

  def index
    # TODO не делать постоянно запросы. Закешировать
    @topics = $discourse.category_latest_topics('kompaniya/novosti').
      reject{|topic| topic['pinned']}.
      sort_by{|topic| topic['created_at']}.
      reverse.
      take(5)
    #@news = News.order(date: :desc).page(params[:page]).per(params[:per])
  end

end
