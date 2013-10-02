# encoding: utf-8

class UsersController < ApplicationController
  before_action :only_authenticated, :only => [:show]

  before_filter { @tab = params[:tab] || 'users' }

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def logout_from_all_places
    @user.generate_token :auth_token, :long
    @user.save!
    redirect_to root_path, notice: "Вы успешно вышли со всех компьютеров, где использовалась ваша учетная запись."
  end

end
