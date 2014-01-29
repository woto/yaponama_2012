# encoding: utf-8
#
class Admin::BrandsController < BrandsController
  include Admin::Admined
  include GridBrand

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy, :search]

  private

  def set_user_and_creation_reason
    super
    @resource.phantom = false
  end

  def set_resource_class
    @resource_class = Brand
  end

end
