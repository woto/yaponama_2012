class Admin::Products::InorderController < Products::InorderController
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  def set_user
    @user = User.find(params[:user_id]) if prams[:user_id]
  end
end
