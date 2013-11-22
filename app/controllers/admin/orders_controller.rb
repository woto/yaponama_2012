# encoding: utf-8
#
class Admin::OrdersController < OrdersController
  include Admin::Admined

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id].present?
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

end
