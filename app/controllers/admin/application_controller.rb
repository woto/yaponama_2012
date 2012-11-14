class Admin::ApplicationController < ActionController::Base
  layout 'admin'
  protect_from_forgery
  before_filter :prepend_view_paths

  def prepend_view_paths
    prepend_view_path "app/views/admin"
  end


  # Сужение области по покупателю и заказу на основе текущего местоположения (адреса страницы) менеджера,
  # а так же таба (отдельные случаи - виртуальные табы all и checked)
  def products_user_order_tab_scope products, status

    if params[:user_id]
      products = products.where(:user_id => params[:user_id])
    end

    if params[:order_id]
      products = products.where(:order_id => params[:order_id]) 
    end

    case status
      when *Rails.configuration.products_status.select{|k, v| v['real']}.keys
        products = products.where(:status => status)
      when 'checked'
        products = products.where('id IN (?)', session[:products] && session[:products].keys)
    end

    products
    
  end

end
