class Admin::PasswordsController < PasswordsController
  include Admin::Admined

  def set_user
    @somebody = @user = User.find(params[:id]) if params[:id]
  end

end
