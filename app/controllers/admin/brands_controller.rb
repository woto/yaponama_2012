# encoding: utf-8
#
class Admin::BrandsController < BrandsController
  include Admin::Admined
  include Grid::Brand

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy, :search]

  private

  def set_user_and_creation_reason
    super
    @resource.phantom = false
  end

end
