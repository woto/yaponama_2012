# encoding: utf-8
#
class Admin::ModificationsController < ModificationsController
  include Admin::Admined
  include GridModification

  skip_before_action :set_grid, :only => [:new, :edit, :update, :create, :destroy, :show, :search]

  def new_resource
    super
    @resource.generation_id = params[:generation_id]
  end

  private

  def set_resource_class
    @resource_class = Modification
  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

end
