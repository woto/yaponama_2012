class UsersController < ApplicationController

  private

  def find_resource
    @resource = current_user
  end

  def set_resource_class
    @resource_class = User
  end

  def resource_params
    params.require(:user).permit(:name, :email, :phone, :notes)
  end

end
