class GenerationsController < ApplicationController

  def search
    @q = Generation.ransack(params[:q])
    @generations = @q.result(distinct: true)
    @generations = @generations.where(:model_id => params[:model_id]) if params[:model_id]
    @generations = @generations.order(:name).page params[:page]

    respond_to do |format|
      format.json { render json: @generations }
    end
  end 

end
