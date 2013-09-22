# encoding: utf-8

class PasswordsController < ApplicationController

  before_action { @meta_title = 'Смена пароля' }

  def edit
  end

  def update
    respond_to do |format|

      @user.assign_attributes(user_params)
      @user.password_required = true

      if @user.save
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Пароль был успешно изменен.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

end
