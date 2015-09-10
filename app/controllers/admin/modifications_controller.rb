class Admin::ModificationsController < ApplicationController

  skip_before_action :find_resource, :only => :search

  def search
    modification_t = Modification.arel_table

    @modifications = Modification

    if params[:name].present?
      @modifications = @modifications.where(modification_t[:name].matches("#{params[:name]}%"))
    end

    if params[:generation_id]
      @modifications = @modifications.where(:generation_id => params[:generation_id])
    end

    @modifications = @modifications.order(modification_t[:name]).page params[:page]

    respond_to do |format|
      format.json { render json: @modifications }
    end
  end

  private

  def new_resource
    super
    @resource.generation_id = params[:generation_id]
  end

  def set_resource_class
    @resource_class = Modification
  end

end
