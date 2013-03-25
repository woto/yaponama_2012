#encoding: utf-8

module Admined

  extend ActiveSupport::Concern

  included do

    before_action :prepend_view_paths
    before_action :only_authenticated
    before_action :set_supplier

    layout 'admin'

    def prepend_view_paths
      prepend_view_path "app/views/admin"
    end

    def only_authenticated
      unless ['admin', 'manager'].include? current_user.role
        redirect_to root_path, :notice => "У вас нет доступа к этой части сайта." and return
      end
    end

    def set_user
      @user = User.find(params[:user_id]) if params[:user_id]
    end

    def set_order
      @order = Order.find(params[:order_id]) if params[:order_id]
    end

    def set_supplier
      @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
    end

  end

end
