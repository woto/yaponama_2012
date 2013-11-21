# encoding: utf-8
#
class GenerationsController < ApplicationController

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

end

