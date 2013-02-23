# encoding: utf-8

class SessionsController < ApplicationController
  # Это правильно, что только авторизованный пользователь может выйти с сайта,
  # но как бы правильно это не было этого не надо
  # before_filter :only_authenticated_filter, :only => [:destroy]
  skip_filter :only_authenticated_filter, :only => [:new, :create]
  before_filter :only_not_authenticated_filter, :only => [:new, :create]

  def new
  end

  def create
    debugger

    email_address = EmailAddress.find_by_email_address(params[:login])
    phone = Phone.find_by_phone(params[:login])

    authenticated = nil

    if email_address.present?
      authenticated_user = email_address.user.authenticate(params[:password])
    elsif phone.present?
      authenticated_user = phone.user.authenticate(params[:password])
    end

    if authenticated_user
      if params[:remember_me]
        cookies.permanent[:auth_token] = { :value => authenticated_user.auth_token, :expires => 1.hour.from_now }
      else
        cookies[:auth_token] = { :expire => nil, :value => authenticated_user.auth_token } 
      end

      #reset_session
      #session[:user_id] = authenticated.id

      redirect_to polymorphic_path([namespace_helper, :root]), :notice => "Вы успешно вошли."
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


  private

  def only_authenticated_filter
    unless ["admin", "manager", "user"].include? current_user.role
      redirect_to login_path, :alert => "Пожалуйста войдите на сайт." and return
    end
  end


end
