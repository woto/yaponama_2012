class Admin::Products::EditController < Admin::ProductsController

  before_filter do
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    if @products.size > 1
      redirect_to :back, :alert => "Can not edit more than one product at once" and return
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
        format.html { render action: "edit" }
        format.json { render json: product.errors, status: :unprocessable_entity }
      end
    end
  end

end
