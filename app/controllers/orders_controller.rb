class OrdersController < ApplicationController 

  before_filter :only => [:create, :update] do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' ) 
      products_any_checked_validation
      products_belongs_to_one_user_validation!
      products_all_statuses_validation ["incart", "inorder", "ordered", "pre_supplier", "cancel"]

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end

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
    @order = Order.new(order_params)

    ActiveRecord::Base.transaction do

      respond_to do |format|

        if @order.save

          @products.each do |product|
            product.order = @order
            product.status = 'inorder'
            product.save
          end

          @order.user = @products.first.user

          format.html { redirect_to_relative_path('inorder') and return }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { render template: "/products/inorder/action" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.json
  def update

    @order = Order.find(params[:id])

    ActiveRecord::Base.transaction do

      @order.assign_attributes(order_params)
      
      respond_to do |format|

        if @order.save

            @products.each do |product|
              product.order = @order
              product.status = 'inorder'
              product.save
            end

            format.html { redirect_to_relative_path('inorder') and return }
            format.json { head :no_content }
          else
            format.html { render template: "/products/inorder/action" }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
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

  private

  def order_params
    params.require(:order).permit!
  end

end
