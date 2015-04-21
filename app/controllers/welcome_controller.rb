class WelcomeController < ApplicationController
  include SetResourceClassDummy

  #layout 'lightweight'

  def index
    @topics = get_faqs
  end

end
