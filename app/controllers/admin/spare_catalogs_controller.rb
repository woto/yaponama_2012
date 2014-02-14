class Admin::SpareCatalogsController < SpareCatalogsController
  include Admin::Admined
  before_filter :set_grid, except: [:create, :update, :destroy, :search]
  skip_before_action :find_resource, :only => :search

  respond_to :json

  def search
    t = SpareCatalog.arel_table

    @resources = SpareCatalog

    if params[:name].present?
      @resources = SpareCatalog.where(t[:name].matches("%#{params[:name]}%"))
    end

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end
end
