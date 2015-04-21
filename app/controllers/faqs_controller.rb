class FaqsController < ApplicationController

  def index
    @topics = get_faqs.
      reject{|topic| topic['closed']}
  end

end
