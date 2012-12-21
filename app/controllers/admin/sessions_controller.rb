#encoding: utf-8

class Admin::SessionsController < SessionsController
  include Admin::AddAdminViewPathHelper
  #skip_filter :only_authenticated_filter, :only => [:new, :create]
end
