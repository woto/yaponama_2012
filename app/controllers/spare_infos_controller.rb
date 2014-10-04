# encoding: utf-8
#
class SpareInfosController < ApplicationController

  respond_to :json

  include Grid::SpareInfo

  skip_before_action :find_resource, :only => :search

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy, :search]

  # TODO Не забыть вернуть!
  skip_before_action :verify_authenticity_token

  def search
    spare_info_t = SpareInfo.arel_table

    @resources = SpareInfo

    if params[:name].present?
      catalog_number, manufacturer  = params[:name].split(/\s/).map(&:strip)
      @resources = SpareInfo.where(spare_info_t[:catalog_number].matches("#{catalog_number}%"))
      @resources = @resources.where(spare_info_t[:cached_brand].matches("#{manufacturer}%"))
    end

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end

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
  #      format.html { redirect_to '', attention: 'Spare info was successfully updated.' }
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

  def new_resource
    @resource = @resource_class.new(resource_params)
  end

end
