# encoding: utf-8
#
class Admin::UsersController < Admin::ApplicationController

  before_filter { @tab = params[:tab] || 'users' }


  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:ping, :email_addresses, :phones, :names, :account).order("pings.updated_at DESC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def edit
    @user = User.where(:id => params[:id]).first

    unless @user
      @user = User.new(Rails.configuration.default_user_attributes, :as => current_user.role.to_sym)
      @user.creation_reason = :manager

      unless @user.account
        @user.build_account
      end
    end

    render "edit"

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(Rails.configuration.default_user_attributes.merge( params[:user] || {} ), :as => current_user.role.to_sym)

    unless @user.persisted?
      @user.creation_reason = :manager
      @user.build_account
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Пользователь был успешно создан.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user], :as => current_user.role.to_sym)
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Пользователь был успешно изменен.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

end
