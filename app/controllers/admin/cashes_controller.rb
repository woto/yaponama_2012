class Admin::CashesController < ApplicationController
  include Admined

  def new
    @cash = Cash.new
  end

  def create
    @cash = Cash.new(cash_params)

    respond_to do |format|
      if @cash.valid?
        @user.account.money_transactions.create(:debit => @cash.debit)
        format.html { redirect_to [:admin, @user], notice: 'Cash was successfully created.' }
        format.json { render json: @cash, status: :created, location: @cash }
      else
        format.html { render action: "new" }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end

  end

  private 

  def cash_params
    params.require(:cash).permit!
  end

end
