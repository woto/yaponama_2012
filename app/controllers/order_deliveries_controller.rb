class OrderDeliveriesController < ApplicationController

  #def create
  #  respond_to do |format|
  #    if @resource.save
  #      format.js { redirect_to url_for(:action => :new) }
  #    else
  #      debugger
  #      format.js { render action: 'new' }
  #    end
  #  end
  #end

  private

    #def new_resource
    #  @resource = OrderDelivery.new(postal_address_type: 'new')
    #end

    def set_resource_class
      @resource_class = OrderDelivery
    end

    #def resource_params
    #  # TODO DANGER!
    #  params.fetch(Order.name.underscore.gsub('/', '_').to_sym, {}).permit!
    #end

end
