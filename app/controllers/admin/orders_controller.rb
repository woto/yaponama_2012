class Admin::OrdersController < Admin::ApplicationController
  # GET /admin/orders
  # GET /admin/orders.json
  def index
    @orders = Order.order("id DESC").page(params[:page])

    if params[:user_id]
      @orders = @orders.where(:user_id => params[:user_id])
    end

    if Rails.configuration.orders_status.select{|k, v| v[:real]}.keys.include? params[:status]
      @orders = @orders.where(:status => params[:status])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /admin/orders/new
  # GET /admin/orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /admin/orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /admin/orders
  # POST /admin/orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to admin_order_path(@order), notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to admin_order_path(@order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1
  # DELETE /admin/orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def inorder_doit_create
    inorder_products_validation
    @order = Order.new(params[:order])
    @order.products << @products
    @order.user = @products.first.user
    if @order.save
      @products.each do |product|
        product.update_attributes(:status => 'inorder')
      end
      render :text => "Ok!"
    else
      render 'inorder_action'
    end
  end

  def inorder_doit_update
    inorder_products_validation
    @order = Order.find(params[:id])
    @order.assign_attributes(params[:order])
    @order.products << @products
    @order.user = @products.first.user
    if @order.save
      @products.each do |product|
        product.update_attributes(:status => 'inorder')
      end
      render :text => "Ok!"
    else
      render 'inorder_action'
    end
  end


  def inorder_index
    inorder_products_validation
  end

  def inorder_action
    inorder_products_validation
    @order = Order.where(:id => params[:id]).first
    unless @order
      @order = Order.new
    end
  end

  #def inorder_create
  #  @order = Order.where(:id => params[:id]).first
  #  unless @order
  #    @order = Order.new
  #  end

  #  @order.valid?
  #  render 'inorder_action'

  #end

  def inorder_order_select
    inorder_products_validation

    @order = Order.where(:id => params[:new_order_id]).first

    if @order.present? || params[:new_order_id] == 'new'
      redirect_to inorder_action_admin_order_path((@order.present? && @order.persisted?) ? @order : 'new', :user_id => params[:user_id], :order_id => params[:order_id]) and return
    else
      redirect_to polymorphic_path([:inorder_index, :admin, :orders], :user_id => params[:user_id], :order_id => params[:order_id]), :alert => 'Please choose order or create new' and return
    end
  end

  private


  def inorder_products_validation

    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    unless @products.present?
      redirect_to :back, :alert => ['Neither products selected'] and return false
    end

    # Проверка принадлежности товаров одному пользователю (независимо с какой страницы был сделан запрос)
    if ( errors = products_belongs_to_one_user_validation(@products) ).present?
     redirect_to :back, :alert => errors and return false
    end

    # Проверка допустимых статусов товаров для данного действия
    if ( errors = products_in_allowed_statuses_validation(@products) ).present?
      redirect_to :back, :alert => errors and return false
    end

    return true

  end

  # Проверка принадлежности продуктов одному покупателю
  def products_belongs_to_one_user_validation products

    errors = []

    first_user = products.first.user

    products.each do |product|
      unless product.user == first_user
        errors << "Inordered products must be of one user, but there is: '#{product.user.to_label}' and '#{first_user.to_label}'"
      end
    end

    errors

  end

  # Нельзя обрабатывать товар, не находящийся в корзине, либо в заказе
  def products_in_allowed_statuses_validation products

    errors = []

    products.each do |product|
      unless ["incart", "inorder", "ordered"].include? product.status
        errors << "Inordered product can't be in status: '#{product.status}'"
      end
    end

    errors

  end

end
