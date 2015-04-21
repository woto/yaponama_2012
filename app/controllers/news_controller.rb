class NewsController < ApplicationController

  def index
    @topics = get_news.
      reject{|topic| topic['pinned']}.
      reject{|topic| topic['closed']}.
      take(5)
  end

end
