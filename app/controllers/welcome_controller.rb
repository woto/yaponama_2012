class WelcomeController < ApplicationController
  skip_before_action :find_resources

  def index
    @topics = get_faqs
  end

end
