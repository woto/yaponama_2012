# encoding: utf-8
#
class DeliveriesController < ApplicationController
  
  include SetResourceClassDummy

  def index 
    @deliveries = Delivery.where(Delivery.arel_table[:type].not_eq("Delivery::Shop"))
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

end
