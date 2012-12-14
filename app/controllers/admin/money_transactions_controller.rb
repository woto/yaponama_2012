class Admin::MoneyTransactionsController < Admin::ApplicationController
  # GET /admin/transactions
  # GET /admin/transactions.json
  def index
    money_transactions = MoneyTransaction.order("id DESC").page params[:page]

    opts = ['user', 'supplier']

    opts.each do |opt|
      if params["#{opt}_id"].present?
        t = MoneyTransaction.arel_table

        klass = eval(opt.capitalize)
        account_id = klass.find(params["#{opt}_id"]).account.id

        money_transactions = money_transactions.where(
          t[:left_account_id].eq(account_id).
          or(t[:right_account_id].eq(account_id))
        )
      end
    end

    @money_transactions = money_transactions


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /admin/transactions/1
  # GET /admin/transactions/1.json
  def show
    @transaction = MoneyTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /admin/transactions/new
  # GET /admin/transactions/new.json
  def new
    @transaction = MoneyTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /admin/transactions/1/edit
  def edit
    @transaction = MoneyTransaction.find(params[:id])
  end

  # POST /admin/transactions
  # POST /admin/transactions.json
  def create
    @transaction = MoneyTransaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to admin_transaction_path(@transaction), notice: 'MoneyTransaction was successfully created.' }
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
    @transaction = MoneyTransaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to admin_transaction_path(@transaction), notice: 'MoneyTransaction was successfully updated.' }
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
    @transaction = MoneyTransaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to admin_transactions_url }
      format.json { head :no_content }
    end
  end
end
