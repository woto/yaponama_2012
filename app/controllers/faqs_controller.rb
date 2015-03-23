class FaqsController < ApplicationController

  def index
    # TODO не делать постоянно запросы. Закешировать
    @topics = $discourse.category_latest_topics 'kompaniya/chastye-voprosy'
  end

end
