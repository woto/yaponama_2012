class Admin::Products::CancelController < Products::CancelController
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
