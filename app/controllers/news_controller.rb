class NewsController < ApplicationController

  private

  def find_resources
    @resources = get_news.
      reject{|topic| topic['pinned']}.
      reject{|topic| topic['closed']}.
      take(5)
  end

end
