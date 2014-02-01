# encoding: utf-8
#
class PasswordsController < ApplicationController

  include SetUserAndCreationReasonDummy

  before_action { @meta_title = 'Смена пароля' }

  def update
    respond_to do |format|

      @resource.assign_attributes(resource_params)
      @resource.password_required = true

      if @resource.save
        format.html { redirect_to url_for(controller: :users, action: :show), :success => 'Пароль был успешно изменен.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private

  def find_resource
    @resource = @user
  end

  def set_resource_class
    @resource_class = User
  end

end
