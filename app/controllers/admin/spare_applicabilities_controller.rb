# encoding: utf-8
#
class Admin::SpareApplicabilitiesController < ApplicationController
  include Grid::SpareApplicability
  include Admin::Admined

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy]

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
    @resource_class = SpareApplicability
  end

  def new_resource
    @resource = @resource_class.new(resource_params)
  end

end
