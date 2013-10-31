# encoding: utf-8

class UsersController < ApplicationController

  include GridUser

  skip_before_filter :set_grid, :only => [:create, :update, :logout_from_all_places, :show]

  #before_action :only_authenticated, :only => [:show]

  #def show
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render :json => @resource }
  #  end
  #end

  def logout_from_all_places
    @resource.generate_token :auth_token, :long
    @resource.save!
    redirect_to root_path, success: "Вы успешно вышли со всех компьютеров, где использовалась ваша учетная запись."
  end

  #def update
  #  respond_to do |format|
  #    if @resource.update(resource_params)
  #      format.html { redirect_to url_for(action: 'show'), :success => 'Настройки успешно сохранены' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render :action => "edit" }
  #      format.json { render :json => @resource.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

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

  #include GetUserFromResourceDummy

end
