class Admin::ApplicationController < ActionController::Base
   before_filter :prepend_view_paths

   def prepend_view_paths
     prepend_view_path "app/views/admin"
   end

  helper_method :sort_column, :sort_direction
  protect_from_forgery
  layout 'admin'
end
