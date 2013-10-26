class Admin::ModificationsController < ApplicationController
  include Admin::Admined
  include GridModification

  skip_before_action :set_grid, :only => [:new, :edit, :update, :create, :destroy, :show, :search]
  skip_before_filter :only_authenticated, :only => :search

  respond_to :json

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

    respond_with @modifications
  end

  def new_resource
    super
    @resource.generation_id = params[:generation_id]
  end

end
