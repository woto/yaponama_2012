# encoding: utf-8
#
class Admin::ApplicationController < ApplicationController

  layout 'admin'
  protect_from_forgery
  before_filter :prepend_view_paths
  helper_method :products_user_order_tab_scope

  def prepend_view_paths
    prepend_view_path "app/views/admin"
  end

  private

    end
  end

end
