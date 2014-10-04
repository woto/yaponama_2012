# encoding: utf-8
#
class Admin::ModificationsController < ModificationsController
  include Admin::Admined
  include Grid::Modification

  skip_before_action :set_grid, :only => [:new, :edit, :update, :create, :destroy, :show, :search]

  def new_resource
    super
    @resource.generation_id = params[:generation_id]
  end

  private

  def set_resource_class
    @resource_class = Modification
  end

end
