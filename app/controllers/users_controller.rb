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
      # TODO тут может быть так что мыло указано у другого, а регистрируем этого

      @user = current_user

      @user.assign_attributes params[:user], :as => :guest

      @user.phones.first.save
      @user.email_addresses.first.save

      password_present_validation

      respond_to do |format|
        if @user.valid?
          @user.role = "user"
          @user.save!
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

end
