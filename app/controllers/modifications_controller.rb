class ModificationsController < ApplicationController

  def search
    @q = Modification.ransack(params[:q])
    @modifications = @q.result(distinct: true)
    @modifications = @modifications.where(:generation_id => params[:generation_id]) if params[:generation_id]
    @modifications = @modifications.order(:name).page params[:page]

    respond_to do |format|
      format.json { render json: @modifications }
    end
  end

end
