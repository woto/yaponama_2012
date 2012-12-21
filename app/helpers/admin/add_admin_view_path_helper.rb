#encoding: utf-8

module Admin::AddAdminViewPathHelper

  def self.included(base)
    if base < ApplicationController
      base.instance_eval{
        if base < ApplicationController
          before_filter :prepend_view_paths
          layout 'admin'
        end
      }
    end
  end


  def prepend_view_paths
    prepend_view_path "app/views/admin"
  end

end
