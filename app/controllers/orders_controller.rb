# encoding: utf-8
#
class OrdersController < ApplicationController 

  include Grid::Order

  skip_before_filter :set_grid, only: [:edit, :update, :new, :create, :show, :destroy]

  #prepend_before_action do
  #  #include GridProduct
  #  class_eval do
  #    include GridOrder
  #  end
  #end

  #skip_before_action :set_grid, only: [:update, :consignee, :delivery]

  # GET /admin/orders
  # GET /admin/orders.json
  #def index

  #  @orders = Order.order("id DESC").page(params[:page])

  #  if params[:user_id]
  #    @orders = @orders.where(:user_id => params[:user_id])
  #  end

  #  if Rails.configuration.orders_status.select{|k, v| v[:real]}.keys.include? params[:status]
  #    @orders = @orders.where(:status => params[:status])
  #  end

  #  respond_to do |format|
  #    format.html
  #    format.js { render 'application/grid/filter' }
  #  end

  #end

  #append_before_filter :user_get
  #append_before_filter :somebody_get
  #append_before_filter :supplier_get

  # GET /admin/orders/1
  # GET /admin/orders/1.json
  def show
    #redirect_to smart_route({:postfix => [:products]}, :user_id => params[:user_id], :order_id => params[:id]) and return
    redirect_to polymorphic_path([*jaba3, @resource, :products], return_path: params[:return_path]) and return
  end

  ## GET /admin/orders/new
  ## GET /admin/orders/new.json
  #def new
  #  @order = Order.new

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @order }
  #  end
  #end

  ## GET /admin/orders/1/edit
  #def edit
  #  @order = Order.find(params[:id])
  #end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.json
  #def update

  #  @order = Order.find(params[:id])

  #  respond_to do |format|

  #    if @order.update_attributes(order_params)

  #      format.html { redirect_to smart_route({:postfix => [@order]}) and return }
  #      format.json { head :no_content }
  #      else
  #        format.html { render action: "edit" }
  #        format.json { render json: @order.errors, status: :unprocessable_entity }
  #      end
  #    end

  #end


  ## DELETE /admin/orders/1
  ## DELETE /admin/orders/1.json
  #def destroy
  #  @order = Order.find(params[:id])
  #  @order.destroy

  #  respond_to do |format|
  #    format.html { redirect_to :back }
  #    format.json { head :no_content }
  #  end
  #end

  def transactions

    if params[:id]
      @order = Order.find_by_token(params[:id])
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

  #def order_params
  #  params.require(:order).permit!
  #end

  def set_resource_class
    @resource_class = Order
  end

  def find_resource
    @resource = @resource_class.find_by_token(params[:id])
  end

end
