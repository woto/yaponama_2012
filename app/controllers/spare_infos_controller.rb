class SpareInfosController < ApplicationController

  skip_before_action :find_resource, :only => :search

  # TODO Не забыть вернуть!
  skip_before_action :verify_authenticity_token

  def search
    binding.pry
    spare_info_t = SpareInfo.arel_table
    brand_t = Brand.arel_table

    @resources = SpareInfo

    if params[:name].present?
      catalog_number, manufacturer  = params[:name].split(/\s/).map(&:strip)
      @resources = SpareInfo.where(spare_info_t[:catalog_number].matches("#{catalog_number}%"))
      @resources = @resources.joins(:brand).where(brand_t[:name].matches("#{manufacturer}%"))
    end

    @resources = @resources.order(:name).page params[:page]

    respond_to do |format|
      format.json { render json: @resources }
    end
  end

end
