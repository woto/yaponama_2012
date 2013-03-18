class Admin::Products::EditController < Products::EditController
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  def set_user
    @user = User.find(params[:user_id]) if prams[:user_id]
  end
end
