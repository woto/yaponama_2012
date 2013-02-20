#encoding: utf-8

class UsersController < ApplicationController
  before_filter :not_guest

  def edit
    @user = current_user
    if @user.email_addresses.blank?
      @user.email_addresses.build
    end
    if @user.phones.blank?
      @user.phones.build
    end
  end

  def update
    begin
      @user = current_user

      @user.assign_attributes(user_params)

      if @user.phones.last.valid?
        @user.phones = [@user.phones.last]
      else
        @user.phones = [@user.phones.first]
      end
      @user.phones.first.save

      if @user.email_addresses.last.valid?
        @user.email_addresses = [@user.email_addresses.last]
      else
        @user.email_addresses = [@user.email_addresses.first]
      end
      @user.email_addresses.first.save

      @user.password_required = true
      @user.role = "user"

      respond_to do |format|
        if @user.save
          format.html { redirect_to root_path, :notice => "Регистрация завершена. Вы вошли на сайт под своим аккаунтом." }
        else
          format.html { render :action => "edit" }
        end
      end
    rescue ValidationError => e
      render :edit
      #redirect_to :back, :alert => e.message
    end
  end

  private
  
  def not_guest
    if current_user.role != "guest"
      redirect_to root_path, :notice => "Вы уже зарегистририровались и вошли на сайт."
    end
  end

  def user_params
    params.require(:user).permit(
      { :email_addresses_attributes => [:email_address] },
      { :phones_attributes => [:phone, :phone_type] },
      :password,
      :password_confirmation
    )
  end

end
