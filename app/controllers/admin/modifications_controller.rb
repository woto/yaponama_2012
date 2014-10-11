class Admin::ModificationsController < ModificationsController
  include Grid::Modification
  include Admin::Admined

  def new_resource
    super
    @resource.generation_id = params[:generation_id]
  end

end
