# encoding: utf-8
#
class Admin::ProfilesController < ProfilesController
  include Admin::Admined

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

  def user_get
    @user = @resource.somebody
  end

  def somebody_get
    @somebody = @resource.somebody
  end

  def supplier_get
  end

end
