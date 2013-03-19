class Admin::Products::IncartController < Products::IncartController
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
