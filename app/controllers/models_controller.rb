# encoding: utf-8
#
class ModelsController < ApplicationController

  skip_before_filter :only_authenticated, :only => :search
  skip_before_action :find_resource, :only => :search

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

end
