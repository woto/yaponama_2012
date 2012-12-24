#encoding: utf-8

class Admin::ApplicationController < ApplicationController
  include Admin::AddAdminViewPathHelper
  include ProductsHelper
  before_filter :only_authenticated_filter

  private

  def only_authenticated_filter
    if ["guest"].include? current_user.role
      redirect_to admin_login_path, :alert => "У вас нет доступа к этой части сайта. Пожалуйста войдите на сайт." and return
    end
  end

end
