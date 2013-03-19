class Admin::Products::SplitController < Products::SplitController
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
