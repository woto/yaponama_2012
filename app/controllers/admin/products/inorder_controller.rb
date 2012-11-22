class Admin::Products::InorderController < Admin::ProductsController

  def index
    products_validation
    session[:return_url] = view_context.url_for(:back)
  end


  def order_select
    products_validation

    @order = Order.where(:id => params[:new_order_id]).first

    if @order.present? || params[:new_order_id] == 'new'
      redirect_to action_admin_product_path((@order.present? && @order.persisted?) ? @order : 'new', :user_id => params[:user_id], :order_id => params[:order_id]) and return
    else
      redirect_to polymorphic_path([:inorder, :admin, :products], :user_id => params[:user_id], :order_id => params[:order_id]), :alert => 'Please choose order or create new' and return
    end
  end


  def action
    products_validation

    @order = Order.where(:id => params[:id]).first
    unless @order
      @order = Order.new
    end
  end

end
