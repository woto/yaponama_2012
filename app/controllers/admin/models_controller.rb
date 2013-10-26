class Admin::ModelsController < ApplicationController
  include Admin::Admined
  include GridModel

  skip_before_action :set_grid, :only => [:show, :new, :edit, :update, :create, :destroy, :search]
  skip_before_filter :only_authenticated, :only => :search

  respond_to :json

  def search
    model_t = Model.arel_table

    @models = Model

    if params[:name].present?
      @models = @models.where(model_t[:name].matches("#{params[:name]}%"))
    end

    if params[:brand_id].present?
      @models = @models.where(:brand_id => params[:brand_id])
    end
    
    @models = @models.order(model_t[:name]).page params[:page]
    
    respond_with @models
  end

  def new_resource
    super
    @resource.brand_id = params[:brand_id]
  end

end
