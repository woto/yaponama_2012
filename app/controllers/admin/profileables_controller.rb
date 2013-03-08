class Admin::ProfileablesController < ProfileablesController
  include Admin::AddAdminViewPathHelper

  def new
    @resource = @resource_class.new
    @user = User.find(params[:user_id])
  end

  private

  def set_user_and_creation_reason

    @resource.user = User.find(params[:user_id])

    if @resource.creation_reason.blank?
      @resource.creation_reason = 'manager'
    end
  end

  def find_approrirate_resources
    @resources = @resource_class.where(:user_id => params[:user_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end
