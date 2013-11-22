# encoding: utf-8
#
module Admin::Admined

  extend ActiveSupport::Concern

  included do

    before_action :prepend_view_paths
    #before_action :only_authenticated
    #before_action :set_supplier

    layout 'admin'

    private

    def prepend_view_paths
      prepend_view_path "app/views/admin"
    end

    def only_authenticated
      unless ['admin', 'manager'].include? current_user.role
        redirect_to root_path, :danger => "У вас нет доступа к этой части сайта." and return
      end
    end

    def set_user_and_creation_reason
      super
      if @resource.respond_to? :code_1=
        @resource.code_1 = 'backend'
      end

      if @resource.respond_to? :phantom=
        @resource.phantom = false
      end
    end

  end

end
