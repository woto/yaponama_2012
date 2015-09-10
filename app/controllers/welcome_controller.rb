class WelcomeController < ApplicationController

  def index
    @topics = get_faqs
  end

end
