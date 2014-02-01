# encoding: utf-8
#
class DeliveriesController < ApplicationController

  def set_resource_class
    @resource_class = Order
  end

end
