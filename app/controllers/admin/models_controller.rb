# encoding: utf-8
#
class Admin::ModelsController < ModelsController
  include Admin::Admined
  include Grid::Model

  skip_before_action :set_grid, :only => [:show, :new, :edit, :update, :create, :destroy, :search]

  def new_resource
    super
    @resource.brand_id = params[:brand_id]
  end

end
