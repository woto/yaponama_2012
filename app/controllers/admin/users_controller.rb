#!/bin/env ruby
# encoding: utf-8
#
class Admin::UsersController < Admin::ApplicationController
  layout 'users'

  # GET /users
  # GET /users.json
  def index
    @user_filter = UserFilter.new(params[:user_filter])
    @table_fields = Hash.new{|h,k| h[k] = [] }
    @users = User.scoped
    @user_filter.attributes.select{|k, v| v == '1'}.each do |k, v|
      captures = k.match(/(.*)___(.*)/).captures
      @table_fields[captures[0]] << captures[1]
    end

    # @users = User.joins(:ping).order("pings.updated_at DESC")

    # @users = User.joins(:ping).order("pings.updated_at DESC").joins(:names).where(names[:name].matches("%кась%")).uniq
    
    requests = Request.arel_table
    names = Name.arel_table
    #@users = User.joins(:names).where(names[:name].matches("%дени%")).joins(:requests).where(requests[:notes].matches("%шар%")).uniq
    # @users = User.joins(:ping).order("pings.updated_at DESC").joins(:names).where(names[:name].matches("%кась%")).uniq
    #start_date = Time.zone.now - 3.days
    #end_date = Time.zone.now
    #@users = User.where(:created_at => start_date..end_date).joins(:ping)
    @users = User.joins(:ping).order("pings.updated_at DESC")

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

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    if @user.account.blank?
      @user.account = Account.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), :notice => 'User was successfully updated.' }
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
