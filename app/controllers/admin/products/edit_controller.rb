# encoding: utf-8

class Admin::Products::EditController < Admin::ProductsController

  before_filter do
    begin

      @products = products_user_order_tab_scope( Product.scoped, 'checked' )
      products_any_checked_validation
      products_only_one_validation

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create
    Rails.application.routes.recognize_path params[:return_path]
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
