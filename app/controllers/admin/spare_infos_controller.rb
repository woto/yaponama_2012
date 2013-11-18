# encoding: utf-8
#
class Admin::SpareInfosController < SpareInfosController
  include Admin::Admined

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

end
