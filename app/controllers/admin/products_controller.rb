class Admin::ProductsController < Admin::ApplicationController

  ORDER_STEPS = %w[order delivery postal_address phone name notes]
 
  def index
    products = Product.order("id DESC").page(params[:page])
    @products = products_user_order_tab_scope(products, params[:status])
    respond_to do |format|
      format.html
    end
  end

  def multiple_destroy

    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    result = {}

    @products.each do |product|
      if product.destroy
        result = { :notice => "Product Successfully deleted" }
      else
        result = { :alert => "Product can't be deleted: #{product.errors[:base].to_s}" }
        break
      end
    end

    respond_to do |format|
      format.html { redirect_to :back, result }
      format.json { head :no_content }
    end
  end

  #def destroy
  #  @product = Product.find(params[:id])
  #  if @product.destroy
  #    result = { :notice => "Product Successfully deleted" }
  #  else
  #    result = { :alert => "Product can't be deleted: #{@product.errors[:base].to_s}" }
  #  end
  #  respond_to do |format|
  #    format.html { redirect_to :back, result }
  #    format.json { head :no_content }
  #  end
  #end

  def remember
    session[:products] = {} unless session[:products]
    session[:products] = (session[:products].merge params[:product_ids]).select{|k, v| v == '1'}
    respond_to do |format|
      format.js
    end
  end

end
