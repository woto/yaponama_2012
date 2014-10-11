class Admin::ModelsController < ModelsController
  include Grid::Model
  include Admin::Admined

  def new_resource
    super
    @resource.brand_id = params[:brand_id]
  end

end
