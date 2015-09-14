class Admin::ModelsController < ApplicationController
  include Admin::Admined

  private

  def new_resource
    @resource = @resource_class.new(brand_id: params[:brand_id])
  end


  def set_resource_class
    @resource_class = Model
  end
end
