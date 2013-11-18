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

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

end
