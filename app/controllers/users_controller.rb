# encoding: utf-8
#
class UsersController < ApplicationController

  include GridUser

  skip_before_filter :set_grid, :only => [:create, :update, :logout_from_all_places, :show, :postal_address]

  #before_action :only_authenticated, :only => [:show]

  #def show
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render :json => @resource }
  #  end
  #end

  def update
    respond_to do |format|
      if @resource.save
        format.html { redirect_to(url_for(:action => :show), attention: 'Настройки пользователя успешно сохранены') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def postal_address
    @somebody.update(resource_params)
    debugger
    puts
  end

  def logout_from_all_places
    @resource.generate_token :auth_token, :long
    @resource.save!
    respond_to do |format|
      format.html do
        redirect_to root_path, attention: "Вы успешно вышли со всех компьютеров, где использовалась ваша учетная запись."
      end
    end
  end

  #def update
  #  respond_to do |format|
  #    if @resource.update(resource_params)
  #      format.html { redirect_to url_for(action: 'show'), :attention => 'Настройки успешно сохранены' }
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

  #include GetUserFromResourceDummy

end
