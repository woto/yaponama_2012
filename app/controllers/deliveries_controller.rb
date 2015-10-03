class DeliveriesController < ApplicationController
  layout 'lightweight'

  private

  def find_resources
    @topic = get_faqs.find{|faq| faq['id'] == 29}
  end
end
