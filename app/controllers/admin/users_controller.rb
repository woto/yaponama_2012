class Admin::UsersController < ApplicationController
  include Admin::Admined

  private

  def update_resource
    super
    authorize @resource
  end

  def set_resource_class
    @resource_class = User
  end

  def resource_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    params.require(:user).permit([:name, :email, :phone, :notes, :notes_invisible, :role, :password, :password_confirmation])
  end
end
