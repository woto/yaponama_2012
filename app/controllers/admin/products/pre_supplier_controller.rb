class Admin::Products::PreSupplierController < Products::PreSupplierController
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
