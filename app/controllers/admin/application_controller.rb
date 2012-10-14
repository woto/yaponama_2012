class Admin::ApplicationController < ActionController::Base
  layout 'admin'
  protect_from_forgery
  before_filter :prepend_view_paths
  helper_method :sort_column, :sort_direction


  def prepend_view_paths
    prepend_view_path "app/views/admin"
  end

end
