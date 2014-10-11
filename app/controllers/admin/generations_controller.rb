class Admin::GenerationsController < GenerationsController
  include Grid::Generation
  include Admin::Admined

  def new_resource
    super
    @resource.model_id = params[:model_id]
  end

end
