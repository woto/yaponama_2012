class Admin::ProductsController < Admin::ApplicationController

  def remember
    session[:products] = {} unless session[:products]
    session[:products] = (session[:products].merge params[:product_ids]).select{|k, v| v == '1'}
    render :nothing => true
  end

  def index
    @products = Product.order("id DESC").page(params[:page])

    if params[:status] && params[:status] != 'all' && params[:status] != 'checked'
      @products = @products.where(:status => params[:status])
    end

    if params[:status] == 'checked'
      @products = @products.where(['id IN (?)', session[:products].keys])
    end

    if params[:order_id]
      @products = @products.where(:order_id => params[:order_id])
    end

    if params[:user_id]
      @products = @products.where(:user_id => params[:user_id])
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
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

    if @product.destroy
      result = { :notice => "Product Successfully deleted" }
    else
      result = { :alert => "Product can't be deleted: #{@product.errors[:base].to_s}" }
    end

    respond_to do |format|
      format.html { redirect_to :back, result }
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

  def set_cart_action
    @product = Product.find(params[:id])
    @product.status = :incart
    @product.supplier_id = nil
    @product.save
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

  # Отображение оформляемых товаров, выбор заказа или предложение создать новый заказ.
  def inorder_step_one
    @products = Product.find(params[:product_ids])
    errors = []
    errors += check_products_belongs_to_one_user(@products)
    errors += check_products_statuses_is_incart(@products)

    if errors.present?
      redirect_to :back, :alert => errors.uniq
    end
  end

  # Выбор способа доставки
  def inorder_step_two
    @order = Order.where(:id => params[:order_id]).first
    if @order.blank?
      @order = Order.new
    end
    @products = Product.find(params[:product_ids])
    errors = []
    errors += check_products_belongs_to_one_user(@products)
    errors += check_products_statuses_is_incart(@products)
    if errors.present?
      render 'inorder_step_one', :alert => errors.uniq
    end
  end

  def inorder_step_three
  
  end

  def inorder_step_four

  end

  def inorder_step_five
    @order = Order.where(:id => params[:order_id]).first
    @products = Product.find(params[:product_ids])
    errors = []
    errors += check_products_belongs_to_one_user(@products)
    errors += check_products_statuses_is_incart(@products)

    ActiveRecord::Base.transaction do
      user = @products.first.user
      if @order
        @order.update_attributes(:delivery_id => params[:delivery_id], :delivery_cost => params[:delivery_cost])
      else
        @order = user.orders.build(:delivery_id => params[:delivery_id], :delivery_cost => params[:delivery_cost])
      end
      @order.products << @products
      @products.each do |product|
        product.update_attributes(:status => "inorder")
      end

      unless user.save
        errors += user.errors
      end
      unless @order.save
        errors += @order.errors
      end
      #user.check_orders

      redirect_to admin_user_order_products_path(@order.user, @order), :notice => 'Order successfully created'
    end
  end
  
  def update_multiple
  end

  def destroy_multiple
    @products = Product.find(params[:product_ids])

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

  private

  def check_products_statuses_is_incart products
    errors = []
    # Нельзя послать товар в заказ не находящийся в корзине
    products.each do |product|
      unless ["incart", "inorder"].include? product.status
        errors << "Products not in status incart"
      end
    end
    errors
  end

  def check_products_belongs_to_one_user products
    errors = []
    # Нельзя послать в заказ товары разных пользователей
    first_user = products.first.user

    products.each do |product|
      unless product.user == first_user
        errors << "Products in different carts of different users."
      end
    end
    errors
  end

end
