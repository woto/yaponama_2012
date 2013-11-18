# encoding: utf-8
#
class Admin::PasswordsController < PasswordsController
  include Admin::Admined

  def user_set
    @resource = @somebody = @user = User.find(params[:id]) if params[:id]
  end

  def supplier_set
  end

  def somebody_set
  end

end
