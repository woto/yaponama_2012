# encoding: utf-8
#
class CashesController < ApplicationController
  def new
    render :text => "CashesController::new"
  end

  def create
  end

  private

  def set_resource_class
    @resource_class = Cash
  end

end
