class SpareInfosController < ApplicationController
  # GET /admin/spare_infos
  # GET /admin/spare_infos.json
  def index
    @admin_spare_infos = SpareInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_spare_infos }
    end
  end

  # GET /admin/spare_infos/1
  # GET /admin/spare_infos/1.json
  def show
    @admin_spare_info = SpareInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_spare_info }
    end
  end

  # GET /admin/spare_infos/new
  # GET /admin/spare_infos/new.json
  def new
    @admin_spare_info = SpareInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_spare_info }
    end
  end

  # GET /admin/spare_infos/1/edit
  def edit
    @admin_spare_info = SpareInfo.find(params[:id])
  end

  # POST /admin/spare_infos
  # POST /admin/spare_infos.json
  def create
    @admin_spare_info = SpareInfo.new(params[:admin_spare_info])

    respond_to do |format|
      if @admin_spare_info.save
        format.html { redirect_to [namespace_helper, @admin_spare_info], notice: 'Spare info was successfully created.' }
        format.json { render json: @admin_spare_info, status: :created, location: @admin_spare_info }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_spare_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/spare_infos/1
  # PUT /admin/spare_infos/1.json
  def update
    @admin_spare_info = SpareInfo.find(params[:id])

    respond_to do |format|
      if @admin_spare_info.update_attributes(params[:admin_spare_info])
        format.html { redirect_to [namespace_helper, @admin_spare_info], notice: 'Spare info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_spare_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/spare_infos/1
  # DELETE /admin/spare_infos/1.json
  def destroy
    @admin_spare_info = SpareInfo.find(params[:id])
    @admin_spare_info.destroy

    respond_to do |format|
      format.html { redirect_to [namespace_helper, :spare_infos] }
      format.json { head :no_content }
    end
  end
end
