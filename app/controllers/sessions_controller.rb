# encoding: utf-8

class SessionsController < ApplicationController
  
  include FindResourceByIdDummy
  include FindResourceDummy
  include SetUserAndCreationReasonDummy

  before_action :only_authenticated, :only => [:destroy]
  before_action :only_not_authenticated, :only => [:new, :create]
  before_action { @meta_title = 'Вход на сайт' }


  def new
    @session = Session.new(mobile: true)
  end

  def create
    @session = Session.new(session_params)
    @session.code_2 = params[:with]

    if @session.valid?

      authenticated_user = @session.user

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
      # TODO наверное круто было бы, если бы я делал merge пользователей

      redirect_to user_path, :success => "Вы успешно вошли."
    else
      render 'new'
    end

  end

  def destroy
    #session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_path, :success => "Вы успешно вышли."
  end

  def session_params
    params.require(:session).permit!
  end

  private

  def set_resource_class
    @resource_class = Session
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

end
