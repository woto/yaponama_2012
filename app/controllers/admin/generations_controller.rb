class Admin::GenerationsController < GenerationsController
  include Admin::Admined

  def new_resource
    super
    @resource.model_id = params[:model_id]
  end

end
