class Admin::GenerationsController < ApplicationController
  include Admin::Admined

  private

  def new_resource
    @resource = @resource_class.new(model_id: params[:model_id])
  end

  def set_resource_class
    @resource_class = Generation
  end
end
