class User::OrdersController < ApplicationController

  private

  def set_resource_class
    @resource_class = Order
  end

end
