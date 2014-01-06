# encoding: utf-8
#
class RegistersController < ApplicationController

  include SetResourceClassDummy
  include FindResourceDummy
  include SetUserAndCreationReasonDummy
  include UpdateResourceDummy

  before_action :only_not_authenticated, :only => [:edit, :update, :show]
  before_action { @meta_title = 'Регистрация' }

  def edit
    @user = current_user
    @profile = @user.profiles.first_or_initialize
    @email = @profile.emails.first_or_initialize
    @phone = @profile.phones.first_or_initialize
    @name = @profile.names.first_or_initialize
  end

  def update
    @user = current_user
    respond_to do |format|
      @user.code_1 = 'register'
      @user.code_2 = params[:with]
      if @user.update_attributes(user_params)
        format.html { redirect_to user_path, :success => "Регистрация завершена. Вы успешно вошли на сайт под своей учетной записью." }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  
  def user_params
    #params.require(:user).permit!
    params.require(:user).permit( { 
      :profiles_attributes => [ 
        :id,
        { :names_attributes => [:id, :name, :hidden_recreate] },
        { :emails_attributes => [:id, :value, :hidden_recreate] },
        { :phones_attributes => [:id, :value, :hidden_recreate] },
      ] },
      :password,
      :password_confirmation
    )
  end

  def user_set
    @user = current_user
  end
  
  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end


end
