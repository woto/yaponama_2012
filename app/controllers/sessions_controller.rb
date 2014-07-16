# encoding: utf-8
#
class SessionsController < ApplicationController
  
  include FindResourceByIdDummy
  include FindResourceDummy
  include SetUserAndCreationReasonDummy
  include SessionsPasswordResetsCommon

  before_action :only_authenticated, :only => [:destroy]
  before_action :only_not_authenticated, :only => [:show, :new, :create]
  before_action { @meta_title = 'Вход на сайт' }


  def new
    @session = Session.new(mobile: true)
  end

  def create
    @session = Session.new(session_params)
    @session.code_2 = params[:with]

    if @session.valid?

      authenticated_user = @session.user

      session_password_resets_common current_user, authenticated_user

      attention = 'Вы успешно вошли, добро пожаловать!'
      if authenticated_user.seller?
        redirect_to admin_path, attention: attention
      else
        redirect_to user_path, attention: attention
      end

    else
      render 'new'
    end

  end

  def destroy
    #session[:user_id] = nil
    cookies.delete(:auth_token)
    cookies.delete(:role)
    redirect_to root_path, attention: 'Вы успешно вышли, всего доброго.'
  end

  def session_params
    params.require(:session).permit!
  end

  private

  def set_resource_class
    @resource_class = Session
  end

end
