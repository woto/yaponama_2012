class Admin::BotsController < ApplicationController
  include Admin::Admined

  def preview
    @resource = @resource_class.finder(params[:id])

    @resources = User
    @resources = @resources.matched_records_by_remote_ip(@resource.cidr) if @resource.inet?
    @resources = @resources.matched_records_by_user_agent(@resource.user_agent) if @resource.user_agent?
    @resources = @resources.page(params[:page]).per(params[:per])
  end

  private

  def set_resource_class
    @resource_class = Bot
  end

  def find_resources
    super
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
  end

end
