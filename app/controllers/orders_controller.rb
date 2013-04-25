class OrdersController < ApplicationController 
  include GridConcern

  before_action do
    class_eval do
      include OrdersConcern
    end
  end

  before_action :except => [:index, :filter] do
    class_eval do
      include ProductsConcern
    end
  end

  before_action :except => [:show] do
    set_resource_class
    set_grid_class
    set_grid
  end

  before_filter :only => [:create, :update] do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' ) 
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
      format.html
      format.js { render 'shared/filter' }
    end

  end


  def filter

    respond_to do |format|
      format.html
      format.js { render 'shared/filter' }
    end

  end

  # GET /admin/orders/1
  # GET /admin/orders/1.json
  def show
    redirect_to smart_route({:postfix => [:products]}, :user_id => params[:user_id], :order_id => params[:id]) and return
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

    @order.user = @items.first.user

    ActiveRecord::Base.transaction do

      respond_to do |format|

        if @order.save

          @items.each do |item|
            item.order = @order
            item.status = 'inorder'
            item.save
          end

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

            @items.each do |item|
              item.order = @order
              item.status = 'inorder'
              item.save
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

  def transactions

    if params[:id]
      @order = Order.find(params[:id])
      @transactions = @order.order_transactions
    else
      if @user
        @transactions = @user.order_transactions
      else
        @transactions = OrderTransaction.all
      end
    end

    @transactions = @transactions.order(:id => :desc)
  end

  private

  def order_params
    params.require(:order).permit!
  end


end
