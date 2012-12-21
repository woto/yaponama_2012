#encoding: utf-8

class Admin::ApplicationController < ApplicationController
  include Admin::AddAdminViewPathHelper
  include ProductsHelper
  before_filter :only_authenticated_filter

  private

  def only_authenticated_filter
    unless ["admin", "manager"].include? current_user.role
      redirect_to root_path, :alert => "У вас нет доступа к этой части сайта." and return
    end
  end

end
