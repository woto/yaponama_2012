class Admin::ProductTransactionsController < Admin::ApplicationController
  # GET /admin/product_transactions
  # GET /admin/product_transactions.json
  def index
    product_transaction = ProductTransaction.scoped.order("id DESC").page params[:page]

    if params[:product_id]
      product_transaction = product_transaction.where(:product_id => params[:product_id])
    end

    @product_transactions = product_transaction

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
