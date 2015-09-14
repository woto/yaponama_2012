class SpareInfosController < ApplicationController

  def search
    s_tt = SpareInfo.arel_table
    b_tt = Brand.arel_table

    @q = SpareInfo.ransack(params[:q])
    @spare_infos = @q.result(distinct: true)
    @spare_infos = @spare_infos.
      includes(:brand).
      references(:brand).
      order(:catalog_number, b_tt[:name].desc).
      page(params[:page])

    respond_to do |format|
      format.json {render json: @spare_infos.as_json(only: [:id], methods: [:name])}
    end
  end

end
