class ProductsController < ApplicationController

  include ProductSerializer
  include ProductsSearch

  def new
    respond_to do |format|
      format.html do
        @moscow = get_faqs.find{|faq| faq['id'] == 30}
        @russia = get_faqs.find{|faq| faq['id'] == 29}
        @our_works = get_our_works.
          reject{|topic| topic['pinned']}.
          reject{|topic| topic['closed']}
        search params[:catalog_number], params[:manufacturer], params[:replacements]
      end
    end
  end

  def create
    respond_to do |format|
      format.js do
        if params[:offer].blank?
          render 'please_choose_offer'
        else
          @resource.save!
          render 'create'
        end
      end
    end
  end

  private

  def set_resource_class
    @resource_class = Product
  end

  def create_resource
    @resource = @resource_class.new(resource_params.merge(user: current_user, creator: current_user, status: 'incart'))
  end

  def resource_params
    begin
      deserialize_product(params[:offer])
    rescue
      {}
    end
  end

end
