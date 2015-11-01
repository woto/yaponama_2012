class DeliveriesController < ApplicationController
  layout 'lightweight'

  private

  def find_resources
    @moscow = get_faqs.find{|faq| faq['id'] == 30}
    @russia = get_faqs.find{|faq| faq['id'] == 29}
  end
end
