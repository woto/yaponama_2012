#encoding: utf-8

class RegistersController < ApplicationController

  before_action :only_not_authenticated, :only => [:edit, :update, :show]

  def edit
    @user = current_user

    if params[:with] == 'email'
      if @user.email_addresses.blank?
        @user.email_addresses.build
      end
    end

    if params[:with] == 'sms'
      if @user.phones.blank?
        @user.phones.build
      end
    end

    if @user.names.blank?
      @user.names.build
    end

  end

  def update

    begin

      @user = current_user
      @user.assign_attributes(user_params)

      if @user.names.last.valid?
        @user.names = [@user.names.last]
      else
        @user.names = [@user.names.first]
      end

      @user.names.first.creation_reason = 'register'
      @user.names.first.save

      if params[:with] == 'sms'
        if @user.phones.last.valid?
          @user.phones = [@user.phones.last]
        else
          @user.phones = [@user.phones.first]
        end

        @user.phones.first.creation_reason = 'register'
        @user.phones.first.save
      end

      if params[:with] == 'email'
        if @user.email_addresses.last.valid?
          @user.email_addresses = [@user.email_addresses.last]
        else
          @user.email_addresses = [@user.email_addresses.first]
        end

        @user.email_addresses.first.creation_reason = 'register'
        @user.email_addresses.first.save
      end

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
  
  def user_params
    params.require(:user).permit(
      { :names_attributes => [:name]},
      { :email_addresses_attributes => [:email_address] },
      { :phones_attributes => [:phone, :phone_type] },
      :password,
      :password_confirmation
    )
  end

end
