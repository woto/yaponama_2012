class PartsController < ApplicationController

  def index
    @brand = Brand.find(params[:brand_id])
    @spare_infos = @brand.spare_infos.page(params[:page]).order(id: :desc).per(50)
  end

end
