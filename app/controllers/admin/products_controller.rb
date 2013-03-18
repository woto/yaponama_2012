class Admin::ProductsController < ProductsController
  include Admin::AddAdminViewPathHelper

  private

  def set_user
    @user = User.find(params[:user_id]
  end
end
