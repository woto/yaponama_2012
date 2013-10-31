# encoding: utf-8

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
