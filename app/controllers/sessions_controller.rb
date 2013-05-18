# encoding: utf-8

class SessionsController < ApplicationController
  before_action :only_authenticated, :only => [:destroy]
  before_action :only_not_authenticated, :only => [:new, :create]

  def new
  end

  def create

    email_addresses = EmailAddress.where(:email_address => params[:login])
    phones = Phone.where(:phone => params[:login])

    authenticated_user = nil

    email_addresses.each do |email_address|
      break if authenticated_user = email_address.profile.user.authenticate(params[:password])
    end

    phones.each do |phone|
      break if authenticated_user = phone.profile.user.authenticate(params[:password])
    end

    if authenticated_user
      if params[:remember_me]
        cookies.permanent[:auth_token] = { :value => authenticated_user.auth_token}
      else
        cookies[:auth_token] = { :expire => nil, :value => authenticated_user.auth_token } 
      end

      #reset_session
      #session[:user_id] = authenticated.id
      # TODO Сделал так чтобы если пользователь зарегистрирован в системе, значит он имеет какие-то привилении
      # соответственно старный гостевой аккаунт не нужен и 'он не хотел под ним работать на сайте'
      @user.destroy

      redirect_to url_for(:root), :notice => "Вы успешно вошли."
    else
      flash.now[:alert] = 'Пара e-mail/телефон и пароль не найдены.'
      render 'new'
    end

  end

  def destroy
    #session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_path, :notice => "Вы успешно вышли."
  end

end
