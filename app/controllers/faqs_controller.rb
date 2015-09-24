class FaqsController < ApplicationController
  skip_before_action :find_resource, :find_resources

  def index
    @topics = get_faqs.
      reject{|topic| topic['closed']}
  end

  def show
    @topic = get_faqs.select{|faq| faq['id'] == params[:id].to_i}.first
    render 'show', layout: 'lightweight'
  end

end
