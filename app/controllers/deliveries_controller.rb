# encoding: utf-8
#
class DeliveriesController < ApplicationController

  def index
    ugly_address
  end

  def set_resource_class
    @resource_class = Order
    @postal_address_type = 'deliveries'
  end

end
