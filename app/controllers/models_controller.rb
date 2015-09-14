class ModelsController < ApplicationController

  def search
    @q = Model.ransack(params[:q])
    @models = @q.result(distinct: true)
    @models = @models.where(:brand_id => params[:brand_id]) if params[:brand_id]
    @models = @models.order(:name).page params[:page]

    respond_to do |format|
      format.json {render json: @models}
    end
  end 

end
