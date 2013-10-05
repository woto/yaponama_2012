#encoding: utf-8


module Admin::Admined

  extend ActiveSupport::Concern

  included do

    before_action :prepend_view_paths
    before_action :only_authenticated
    before_action :set_supplier

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

    def set_user
      if params[:user_id].present?
        @user = User.find(params[:user_id]) 
      end
    end

    def set_order
      if params[:order_id].present?
        @order = Order.find(params[:order_id])
      end
    end

    def set_supplier
      if params[:supplier_id].present?
        @supplier = Supplier.find(params[:supplier_id])
      end
    end

  end

end
