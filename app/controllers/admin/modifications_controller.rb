class Admin::ModificationsController < ApplicationController
  include Admin::Admined

  private

  def new_resource
    @resource = @resource_class.new(generation_id: params[:generation_id])
  end

  def set_resource_class
    @resource_class = Modification
  end
end
