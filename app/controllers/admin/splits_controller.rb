class Admin::SplitsController < ApplicationController

  include Admin::Admined
  include SetResourceClassDummy
  include NewResourceDummy
  include FindResourceDummy
  include CreateResourceDummy

  def new
    @resource = Split.new(:product_id => params[:product_id])
  end

  def create
    @resource = Split.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to params[:return_path], success: "Товар успешно разбит на партии" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def resource_params
    params.require(:split).permit(:product_id, :quantity)
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end
  
end
