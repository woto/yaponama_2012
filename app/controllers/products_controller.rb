# encoding: utf-8
#
class ProductsController < ApplicationController

  include GridProduct

  include ProductsSearch

  #ORDER_STEPS = %w[order delivery postal_address phone name notes]
  #before_action do
  #  binding.pry
  #end
  
  before_action do
    if params[:order_id]
      @resource = Order.find(params[:order_id])
      
      if @resource.delivery_variant_id.blank?
        redirect_to polymorphic_path([:edit, *jaba3, :delivery], {id: @resource, return_path: params[:return_path]}) and return
      end

      if @resource.profile.blank?
        redirect_to polymorphic_path([:edit, *jaba3, :consignee], {id: @resource, return_path: params[:return_path]}) and return
      end

      @resource.update_attributes(phantom: false)

      @somebody = @resource.somebody
      @user = @resource.somebody
      @supplier = @resource.somebody
    end
  end

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]
  skip_before_filter :find_resource, only: [:incart, :inorder, :inorder_action, :ordered, :pre_supplier, :post_supplier, :post_supplier_action, :stock, :complete, :cancel, :multiple_destroy]

  def new
    search params[:catalog_number], params[:manufacturer], params[:replacements]
  end

  def edit
    search params[:catalog_number], params[:manufacturer], params[:replacements]
  end

  def create

    #search @resource.catalog_number, @resource.cached_brand, nil

    respond_to do |format|
      if @resource.save
        format.html { redirect_to(polymorphic_path([:status, *jaba3, :products], {status: 'incart'}), success: ("Товар <strong>".html_safe + @resource.to_label + "</strong> успешно добавлен в корзину.".html_safe)) }
        format.js { raise 'Это где-нибудь используется?'; redirect_to polymorphic_path([:status, *jaba3, :products], {status: 'incart'}) }
      else
        format.html { render action: 'new' }
        format.js { raise 'Аналогично'; render action: 'new' }
      end
    end
  end

  before_action do
    # Доработать
    Rails.application.routes.recognize_path params[:return_path]
  end

  #before_action do
  #  # TODO если родительский товар удален и мы редактируем этот,
  #  # у которого родительский товар указан на удаленный, то тут
  #  # происходит ошибка
  #  if params[:product_id].present?
  #    @somebody = @user = Product.find(params[:product_id]).somebody
  #  end
  #end

  def destroy
    #binding.pry
    #@items = @items.selected(@grid.item_ids)
    @items = [@resource]
    #binding.pry
    @ic = ItemCollection.new(item_collection_params)
    @ic.operation = 'multiple_destroy'
    #binding.pry
    @somebody = @user = @supplier = @ic.user
    #binding.pry
    multiple_destroy
  end

  def transactions

    transactions = ProductTransaction

    # TODO убрать дублирование @user.id... @supplier.id... (update: уверен?)
    if @somebody
      transactions = ProductTransaction.where("somebody_id_before = ? OR somebody_id_after = ?", @somebody.id, @somebody.id)
      klass = @somebody.class
    end

    if @supplier
      transactions = ProductTransaction.where("supplier_id_before = ? OR supplier_id_after = ?", @supplier.id, @supplier.id )
      klass = @supplier.class
    end

    if params[:id]
      transactions = ProductTransaction.where(:product_id => params[:id])
    end

    @transactions = transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html { render 'profileables/transactions' }
      format.json { render json: @product_transactions }
    end
  end

  before_action :preprocess_filter, :only => [:incart, :inorder, :inorder_action, :ordered, :pre_supplier, :post_supplier, :post_supplier_action, :stock, :complete, :cancel, :multiple_destroy]

  def preprocess_filter
    @items = @items.selected(@grid.item_ids)
    #binding.pry
    @ic = ItemCollection.new(item_collection_params)
    @ic.operation = params[:action]
    #binding.pry
    @somebody = @user = @supplier = @ic.user
  end

  def incart
    if @ic.operate
      redirect_to_relative_path('incart', request.fullpath)
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def inorder
    #if @ic.operate
    #  if @user.orders.where(:status => 'open').empty?
    #    @ic.operation = 'inorder_action'
    #    @ic.order_id = '-1'
    #    if @ic.operate
    #      redirect_to_relative_path('inorder', @ic.order)
    #    else
    #      render 'inorder'
    #    end
    #  else
    #    render 'inorder'
    #  end
    #else
    #  redirect_to params[:return_path], :danger => @ic.errors.full_messages
    #end

    #binding.pry
    if @ic.operate
      render 'inorder'
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end

  end

  def inorder_action
    #binding.pry
    if @ic.operate
      redirect_to_relative_path('inorder', params[:return_path], @ic.order)
    else
      render 'inorder'
      #redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end


  def ordered
    if @ic.operate
      redirect_to_relative_path('ordered', request.fullpath)
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def pre_supplier
    if @ic.operate
      redirect_to_relative_path('pre_supplier', request.fullpath)
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def post_supplier
    if @ic.operate
      render 'post_supplier'
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def post_supplier_action
    # TODO ?
    # @ic.supplier = params[:item_collection][:supplier]

    if @ic.operate
      redirect_to_relative_path('post_supplier', request.fullpath)
    else
      render 'post_supplier'
    end
  end

  def stock
    if @ic.operate
      redirect_to_relative_path('stock', request.fullpath)
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def complete
    if @ic.operate
      redirect_to_relative_path('complete', request.fullpath)
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def cancel
    if @ic.operate
      redirect_to_relative_path 'cancel', request.fullpath
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def multiple_destroy
    if @ic.operate
      redirect_to params[:return_path]
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  private

  def set_resource_class
    @resource_class = Product
  end

  def new_resource
    super
    @resource.product_id = params[:product_id]
  end

end
