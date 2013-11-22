# encoding: utf-8
#
class GenerationsController < ApplicationController

  respond_to :json

  skip_before_filter :only_authenticated, :only => :search
  skip_before_action :find_resource, :only => :search

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

  private 

  def set_resource_class
    @resource_class = Generation
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

end
