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

  # GET /admin/product_transactions/1/edit
  def edit
    @product_transaction = ProductTransaction.find(params[:id])
  end

  # POST /admin/product_transactions
  # POST /admin/product_transactions.json
  def create
    @product_transaction = ProductTransaction.new(params[:product_transaction])

    respond_to do |format|
      if @product_transaction.save
        format.html { redirect_to @product_transaction, notice: 'Product transaction was successfully created.' }
        format.json { render json: @product_transaction, status: :created, location: @product_transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @product_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/product_transactions/1
  # PUT /admin/product_transactions/1.json
  def update
    @product_transaction = ProductTransaction.find(params[:id])

    respond_to do |format|
      if @product_transaction.update_attributes(params[:product_transaction])
        format.html { redirect_to @product_transaction, notice: 'Product transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product_transactions/1
  # DELETE /admin/product_transactions/1.json
  def destroy
    @product_transaction = ProductTransaction.find(params[:id])
    @product_transaction.destroy

    respond_to do |format|
      format.html { redirect_to admin_product_transactions_url }
      format.json { head :no_content }
    end
  end
end
