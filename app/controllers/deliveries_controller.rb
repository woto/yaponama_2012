class DeliveriesController < ApplicationController
  def index 
    @deliveries = Delivery.where(Delivery.arel_table[:type].not_eq("Delivery::Shop"))
  end
end
