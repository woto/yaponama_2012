#encoding: utf-8

class PasswordResetsController < ApplicationController
  before_action :only_not_authenticated, :only => [:new, :create, :edit, :update]

  # TODO проработать еще вопрос с сменой пароля через смс

  # Смена пароля - действие
  def update
    begin
      @user = User.find_by!(password_reset_email_token: params[:id])
      @user.password_required = true

      if @user.password_reset_sent_at < 2.hours.ago
        redirect_to new_admin_password_reset_path, :alert => "В целях безопасности ваша инструкция по восстановлению пароля была признана устаревшей, пожалуйста запросите новую." and return
      elsif @user.update_attributes(user_params)
        redirect_to root_url, :notice => "Вы успешно сменили пароль, теперь можете войти на сайт." and return
      end

      render :edit

    rescue ValidationError => e
      render :edit
      #redirect_to :back, :alert => e.message
    end
  end


  # Смена пароля по токену - форма
  def edit
    @user = User.find_by!(password_reset_email_token: params[:id])
  end

  #def index
  #end

  # Запрос на смену пароля - форма
  def new
  end

  # Запрос на смену пароля - действие
  def create

    email_address = EmailAddress.find_by_email_address(params[:login])
    phone = Phone.find_by_phone(params[:login])

    user = nil

    if email_address.present?
      user = email_address.user
    elsif phone.present?
      user = phone.user
    end

    if user
      user.send_password_reset
      redirect_to root_url, :notice => "Мы отправили вам инструкцию по восстановлеию пароля."
    else
      flash[:alert] = "Мы не смогли найти среди зарегистрированных покупателей указанные вами данные, проверьте ввод и попробуйте еще раз."
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit!
  end

end
