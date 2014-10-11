class Admin::SpareCatalogsController < SpareCatalogsController
  include Admin::Admined

  skip_before_action :find_resource, :only => :search

  def search
    t = SpareCatalog.arel_table

    @resources = SpareCatalog

    if params[:name].present?
      chunks = params[:name].split(/\s/).map(&:strip)
      @resources = SpareCatalog
      chunks.each do |chunk|
        @resources = @resources.where(t[:name].matches("%#{chunk}%"))
      end
    end

    @resources = @resources.order(:name).page params[:page]

    respond_to do |format|
      format.json { render json: @resources }
    end
  end

end
