class OrdersController < ApplicationController 
  include ProductsConcern
  include GridConcern

  before_action :set_resource_class_2, :except => [:create, :update]
  before_action :set_grid_class_2, :except => [:create, :update]
  before_action :set_grid
  #before_action :set_user

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


  private

  def set_resource_class_2
    @resource_class = Order
  end


  def set_grid_class_2

    @grid_class = Class.new(AbstractGrid)

    columns_hash = {}


    columns_hash['id'] = {
      :type => :belongs_to,
      :belongs_to => Product,
    }


    columns_hash['name_id'] = {
      :type => :belongs_to,
      :belongs_to => Name,
    }

    columns_hash['postal_address_id'] = {
      :type => :belongs_to,
      :belongs_to => PostalAddress,
    }

    columns_hash['metro_id'] = {
      :type => :belongs_to,
      :belongs_to => Metro,
    }


    columns_hash['shop_id'] = {
      :type => :belongs_to,
      :belongs_to => Shop,
    }

    columns_hash['delivery_cost'] = {
      :type => :number,
    }


    columns_hash['status'] = {
      :type => :set,
      :set => Hash[*Rails.configuration.orders_status.map{|k, v| [v['title'], k]}.flatten],
    }

    columns_hash['delivery_id'] = {
      :type => :belongs_to,
      :belongs_to => Delivery,
    }

    columns_hash['phone_id'] = {
      :type => :belongs_to,
      :belongs_to => Phone,
    }

    columns_hash['created_at'] = {
      :type => :date,
    }

    columns_hash['updated_at'] = {
      :type => :date,
    }

    columns_hash['creation_reason'] = {
      :type => :set,
      :set => eval("Hash[*Rails.configuration.user_#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
    }

    columns_hash['notes'] = {
      :type => :string,
    }

    columns_hash['notes_invisible'] = {
      :type => :string,
    }

    columns_hash['user_id'] = {
      :type => :belongs_to,
      :belongs_to => User,
    }

    columns_hash['creator_id'] = {
      :type => :belongs_to,
      :belongs_to => User,
    }

    @grid_class.const_set("COLUMNS", columns_hash)

  end

  def set_preferable_columns
    @grid.id_visible = '1'
    @grid.name_id_visible = '1'
    @grid.postal_address_id_visible = '1'
    @grid.metro_id_visible = '1'
    @grid.shop_id_visible = '1'
    @grid.delivery_id_visible = '1'
    @grid.phone_id_visible = '1'
    @grid.notes_visible = '1'
    @grid.updated_at_visible = '1'
  end

  def additional_conditions
    if @user
      @items = @items.where(:user_id => @user.id)
    end
  end


end
