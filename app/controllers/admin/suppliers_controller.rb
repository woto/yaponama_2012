# encoding: utf-8
#
class Admin::SuppliersController < SuppliersController
  include Admin::Admined
  include Grid::Supplier
  #include GetUserFromResourceDummy

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy]

  def create_resource
    @resource = @resource_class.new(resource_params)
    @resource.build_account
  end

  private

  def somebody_set
  end

  def supplier_set
    #super
    if params[:id]
      @somebody = @supplier = Supplier.find(params[:id])
    end
  end

  def find_resource
    @resource = @somebody
  end

  def set_resource_class
    @resource_class = Supplier
  end


end
