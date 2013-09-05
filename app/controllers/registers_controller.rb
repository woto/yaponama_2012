#encoding: utf-8

class RegistersController < ApplicationController

  before_action :only_not_authenticated, :only => [:edit, :update, :show]

  def edit
    @user = current_user
    profile = @user.profiles.new
    profile.emails.new
    profile.phones.new
    profile.names.new
  end

  def update
    @user = current_user
    respond_to do |format|
      @user.code_1 = 'register'
      @user.code_2 = params[:with]
      if @user.update_attributes(user_params)
        format.html { redirect_to user_path, :notice => "Регистрация завершена. Вы успешно вошли на сайт под своей учетной записью." }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  
  def user_params
    params.require(:user).permit( { 
      :profiles_attributes => [
        { :names_attributes => [:name, :hidden_recreate] },
        { :emails_attributes => [:value, :hidden_recreate] },
        { :phones_attributes => [:value, :hidden_recreate] },
      ] },
      :password,
      :password_confirmation
    )
  end

end
