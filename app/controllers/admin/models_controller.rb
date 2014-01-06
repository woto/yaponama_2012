# encoding: utf-8
#
class Admin::ModelsController < ModelsController
  include Admin::Admined
  include GridModel

  skip_before_action :set_grid, :only => [:show, :new, :edit, :update, :create, :destroy, :search]

  def new_resource
    super
    @resource.brand_id = params[:brand_id]
  end

  private

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

end
