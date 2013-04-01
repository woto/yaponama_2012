class AccountTransactionsController < ApplicationController

  # GET /admin/transactions
  # GET /admin/transactions.json
  def index

    @account_transactions = AccountTransaction.all

    if @user
      @account_transactions = @user.account.account_transactions
      klass = @user.class
    end

    if @supplier
      @account_transactions = @supplier.account.account_transactions
      klass = @supplier.class
    end

    @account_transactions = @account_transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /admin/transactions/1
  # GET /admin/transactions/1.json
  def show
    @transaction = AccountTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /admin/transactions/new
  # GET /admin/transactions/new.json
  def new
    @transaction = AccountTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /admin/transactions/1/edit
  def edit
    @transaction = AccountTransaction.find(params[:id])
  end

  # POST /admin/transactions
  # POST /admin/transactions.json
  def create
    @transaction = AccountTransaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to admin_transaction_path(@transaction), notice: 'AccountTransaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/transactions/1
  # PUT /admin/transactions/1.json
  def update
    @transaction = AccountTransaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to admin_transaction_path(@transaction), notice: 'AccountTransaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/transactions/1
  # DELETE /admin/transactions/1.json
  def destroy
    @transaction = AccountTransaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to admin_transactions_url }
      format.json { head :no_content }
    end
  end
end
