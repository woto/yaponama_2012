# encoding: utf-8
#
class Admin::GenerationsController < GenerationsController
  include Admin::Admined
  include Grid::Generation

  skip_before_action :set_grid, :only => [:new, :edit, :update, :create, :destroy, :show, :search]

  def new_resource
    super
    @resource.model_id = params[:model_id]
  end

end
