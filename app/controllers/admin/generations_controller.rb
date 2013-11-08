class Admin::GenerationsController < ApplicationController
  include Admin::Admined
  include GridGeneration

  skip_before_action :set_grid, :only => [:new, :edit, :update, :create, :destroy, :show, :search]
  skip_before_filter :only_authenticated, :only => :search

  respond_to :json

  def search
    generation_t = Generation.arel_table

    @generations = Generation

    if params[:name].present?
      @generations = @generations.where(generation_t[:name].matches("#{params[:name]}%"))
    end

    if params[:model_id]
      @generations = @generations.where(:model_id => params[:model_id])
    end

    @generations = @generations.order(generation_t[:name]).page params[:page]

    respond_with @generations
  end

  def new_resource
    super
    @resource.model_id = params[:model_id]
  end

  private

  def set_resource_class
    @resource_class = Generation
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
