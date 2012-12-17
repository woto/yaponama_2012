# encoding: utf-8

class Admin::Products::EditController < Admin::ProductsController

  before_filter do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_only_one_validation
      products_all_statuses_validation ['incart', 'inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete', 'cancel']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create
    product = @products.first

    respond_to do |format|
      if product.update_attributes(params[:product])
        format.html { redirect_to(params[:return_path], :notice => "Product sucessfully updated.") }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: product.errors, status: :unprocessable_entity }
      end
    end
  end

end
