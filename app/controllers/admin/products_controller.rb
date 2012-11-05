class Admin::ProductsController < Admin::ApplicationController
  def index
    products = Product.scoped

    if params[:status] && params[:status] != 'all'
      products = products.where(:status => params[:status])
    end

    @products = products.all

    respond_to do |format|
      format.html
    end
  end

  def edit
    @product = Product.find(params[:id])
  end


  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_product_path(@product), notice: 'Product info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def set_to_pre_supplier_form
    @product = Product.find(params[:id])
  end

  def set_to_pre_supplier_action
    @product = Product.find(params[:id])
    @product.status = :pre_supplier
    @product.supplier_id = params[:product][:supplier_id]
    @product.save

    supplier = Supplier.find(params[:product][:supplier_id])
    supplier.account.credit += @product.buy_cost * @product.quantity_ordered
    supplier.save
    redirect_to admin_products_path
  end

  def set_to_post_supplier_action
    @product = Product.find(params[:id])
    @product.status = :post_supplier
    @product.save
    redirect_to :back
  end

  def set_cancel_action
    @product = Product.find(params[:id])
    @product.status = :cancel
    user = @product.user
    user.account.debit -= @product.sell_cost * @product.quantity_ordered
    supplier = @product.supplier
    supplier.account.credit -= @product.buy_cost * @product.quantity_ordered
    @product.save
    user.save
    supplier.save
    redirect_to :back
  end

  def set_stock_action
    @product = Product.find(params[:id])
    @product.status = :stock
    @product.save
    supplier = @product.supplier
    supplier.account.credit -= @product.buy_cost * @product.quantity_ordered
    supplier.account.debit -= @product.buy_cost * @product.quantity_ordered
    supplier.save
    redirect_to :back
  end

  def set_complete_action
    @product = Product.find(params[:id])
    @product.status = :complete
    @product.save
    redirect_to :back
  end


end
