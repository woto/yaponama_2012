class ProductTransactionsController < ApplicationController
  # GET /admin/product_transactions
  # GET /admin/product_transactions.json
  def index

    product_transactions = ProductTransaction

    # TODO убрать дублирование @user.id... @supplier.id...
    if @user
      product_transactions = ProductTransaction.where("user_id_before = ? OR user_id_after = ?", @user.id, @user.id)
      klass = @user.class
    end

    if @supplier
      product_transactions = ProductTransaction.where("supplier_id_before = ? OR supplier_id_after = ?", @supplier.id, @supplier.id )
      klass = @supplier.class
    end

    if params[:product_id]
      product_transactions = ProductTransaction.where(:product_id => params[:product_id])
    end

    @product_transactions = product_transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_transactions }
    end
  end

  # GET /admin/product_transactions/1
  # GET /admin/product_transactions/1.json
  def show
    @product_transaction = ProductTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_transaction }
    end
  end

  # GET /admin/product_transactions/new
  # GET /admin/product_transactions/new.json
  def new
    @product_transaction = ProductTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_transaction }
    end
  end

end
