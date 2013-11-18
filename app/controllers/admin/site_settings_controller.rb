# encoding: utf-8
#
class Admin::SiteSettingsController < ApplicationController
  include Admin::Admined
  include SetResourceClassDummy
  include SetUserAndCreationReasonDummy
  include FindResourceDummy

  # GET /admin/site_settings
  # GET /admin/site_settings.json
  def index
    @admin_site_settings = Admin::SiteSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_site_settings }
    end
  end

  # GET /admin/site_settings/1
  # GET /admin/site_settings/1.json
  def show
    @admin_site_setting = Admin::SiteSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_site_setting }
    end
  end

  ## GET /admin/site_settings/new
  ## GET /admin/site_settings/new.json
  #def new
  #  @admin_site_setting = Admin::SiteSetting.new

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @admin_site_setting }
  #  end
  #end

  # GET /admin/site_settings/1/edit
  def edit
    @admin_site_setting = Admin::SiteSetting.find(params[:id])
  end

  # POST /admin/site_settings
  # POST /admin/site_settings.json
  def create
    @admin_site_setting = Admin::SiteSetting.new(admin_site_setting_params)

    respond_to do |format|
      if @admin_site_setting.save
        format.html { redirect_to @admin_site_setting, notice: 'Site setting was successfully created.' }
        format.json { render json: @admin_site_setting, status: :created, location: @admin_site_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_site_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/site_settings/1
  # PUT /admin/site_settings/1.json
  def update
    @admin_site_setting = Admin::SiteSetting.find(params[:id])

    respond_to do |format|
      if @admin_site_setting.update_attributes(admin_site_setting_params)
        format.html { redirect_to @admin_site_setting, notice: 'Site setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_site_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/site_settings/1
  # DELETE /admin/site_settings/1.json
  def destroy
    @admin_site_setting = Admin::SiteSetting.find(params[:id])
    @admin_site_setting.destroy

    respond_to do |format|
      format.html { redirect_to admin_site_settings_url }
      format.json { head :no_content }
    end
  end

  private

  def admin_site_setting_params
    params.require(:admin_site_setting).permit!
  end

  def user_set
  end

  def supplier_set
  end

  def somebody_set
  end

  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

end
