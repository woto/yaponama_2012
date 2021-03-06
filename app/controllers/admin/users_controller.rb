class Admin::UsersController < ApplicationController
  include Admin::Admined

  def impersonate
    @resource = User.find(params[:id])
    authorize @resource
    if @resource.guest?
      session.delete("warden.user.user.key")
      session[:guest_user_id] = @resource.id
    else
      sign_in(:user, @resource)
    end
    redirect_to user_path
  end

  private

  def find_resources
    super
    @q = @resources.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @resources = @q.result(distinct: true)
  end

  def update_resource
    super
    authorize @resource
  end

  def create_resource
    super
    authorize @resource
  end

  def set_resource_class
    @resource_class = User
  end

  def resource_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).permit([:name, :email, :phone, :notes, :notes_invisible,
                                  :role, :password, :password_confirmation])
  end
end
