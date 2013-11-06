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

  private

  def set_resource_class
    @resource_class = Model
  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
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

end
