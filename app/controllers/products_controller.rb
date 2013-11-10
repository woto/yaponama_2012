class ProductsController < ApplicationController

  include ProductsSearch

  def new
    search params[:catalog_number], params[:manufacturer], params[:replacements]
  end

  def edit
    search params[:catalog_number], params[:manufacturer], params[:replacements]
  end

  # create и update идентичны, TODO: устранить
  #def create
  #  case
  #  when params[:commit]
  #    super
  #  when params[:s]
  #    search params[:product][:catalog_number], params[:product][:brand_attributes][:name], '0'
  #  when params[:r]
  #    search params[:product][:catalog_number], params[:product][:brand_attributes][:name], '1'
  #  end
  #end

  #def update
  #  case
  #  when params[:commit]
  #    super
  #  when params[:s]
  #    search params[:product][:catalog_number], params[:product][:brand_attributes][:name], '0'
  #  when params[:r]
  #    search params[:product][:catalog_number], params[:product][:brand_attributes][:name], '1'
  #  end
  #end

  
  before_action do
    # Доработать
    Rails.application.routes.recognize_path params[:return_path]
  end

  before_action do
    if params[:product_id].present?
      @somebody = @user = Product.find(params[:product_id]).somebody
    end
  end

  include GridProduct

  ORDER_STEPS = %w[order delivery postal_address phone name notes]

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy]

  def destroy
    raise 'Нельзя'
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

  def item_collection_params
    hash = params.fetch(:item_collection, {}).permit!
    hash.merge(items: @items)
  end

  before_action :only => [:incart, :inorder, :ordered, :pre_supplier, :post_supplier, :post_supplier_action, :stock, :complete, :cancel, :multiple_destroy]  do
    @items = @items.selected(@grid.item_ids)
    @ic = ItemCollection.new(item_collection_params)
    @ic.operation = params[:action]
  end

  def incart
    if @ic.operate
      redirect_to_relative_path('incart')
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def inorder
    if @ic.operate
      redirect_to_relative_path('inorder')
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def ordered
    if @ic.operate
      redirect_to_relative_path('ordered')
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def pre_supplier
    if @ic.operate
      redirect_to_relative_path('pre_supplier')
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
      redirect_to_relative_path('post_supplier')
    else
      render 'post_supplier'
    end
  end

  def stock
    if @ic.operate
      redirect_to_relative_path('stock')
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def complete
    if @ic.operate
      redirect_to_relative_path('complete')
    else
      redirect_to params[:return_path], :danger => @ic.errors.full_messages
    end
  end

  def cancel
    if @ic.operate
      redirect_to_relative_path 'cancel'
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

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end
  
  def user_get
    @somebody = @user = @resource.somebody
  end

  def somebody_get
  end

  def supplier_get
    @supplier = @resource.supplier
  end

  def new_resource
    super
    @resource.product_id = params[:product_id]
  end

end
