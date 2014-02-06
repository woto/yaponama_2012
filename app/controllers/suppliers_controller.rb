class SuppliersController < ApplicationController

  private
  
  def find_resource
    @resource = @user
  end

  def set_resource_class
    @resource_class = User
  end

end
