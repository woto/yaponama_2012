class WelcomeController < ApplicationController
  include SetResourceClassDummy

  #layout 'lightweight'

  def index
    # TODO Не делать постоянно запросы. Закешировать
    @topics = $discourse.category_latest_topics 'kompaniya/chastye-voprosy'
  end

end
