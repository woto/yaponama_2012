# encoding: utf-8
#
class SpareInfosController < ApplicationController
  include GridSpareInfo

  skip_before_filter :set_grid, only: [:edit, :new, :create, :show, :update]

  def transactions
    render :text => "SpareInfosController::transactions"
  end

  # GET /admin/spare_infos
  # GET /admin/spare_infos.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.js { render 'grid_filter' }
    end
  end

  # GET /admin/spare_infos/1
  # GET /admin/spare_infos/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  ## PUT /admin/spare_infos/1
  ## PUT /admin/spare_infos/1.json
  #def update
  #  respond_to do |format|
  #    if @resource.update(resource_params)
  #      format.html { redirect_to '', success: 'Spare info was successfully updated.' }
  #    else
  #      format.html { render action: "edit" }
  #    end
  #  end
  #end

  ## DELETE /admin/spare_infos/1
  ## DELETE /admin/spare_infos/1.json
  #def destroy
  #  @resource.destroy

  #  respond_to do |format|
  #    format.html { redirect_to [namespace_helper, :spare_infos] }
  #  end
  #end

  private

  def set_resource_class
    @resource_class = SpareInfo
  end

  def user_set
    @somebody = @user = current_user
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

  def new_resource
    @resource = @resource_class.new(resource_params)
  end

end
