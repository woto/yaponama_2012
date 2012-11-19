#!/bin/env ruby
# encoding: utf-8
#
class Admin::UsersController < Admin::ApplicationController

  DEFAULT_USER_ATTRIBUTES = {
    'prepayment_percent' => Rails.configuration.default_prepayment_percent_for_new_users, 
    'discount' => Rails.configuration.default_discount_for_new_users,
    'order_rule' => Rails.configuration.default_order_rule_for_new_users
  }

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
      @user = User.new(DEFAULT_USER_ATTRIBUTES)
      @user.creation_reason = :manager
    end

    render "edit"

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(DEFAULT_USER_ATTRIBUTES.merge(params[:user] || {}))

    unless @user.persisted?
      @user.creation_reason = :manager
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'User was successfully created.' }
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
      if @user.update_attributes(params[:user])
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit", :alert => 'Unable to save user' }
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
