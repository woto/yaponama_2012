#encoding: utf-8

class Admin::CashesController < ApplicationController
  include Admined

  def new
    @cash = Cash.new
    @cash.debit = 0.to_d
  end

  def create
    @cash = Cash.new(cash_params)

    respond_to do |format|
      if @cash.valid? 
        if @cash.debit.to_d != 0
          @user.account.account_transactions.create(:debit => @cash.debit, :comment => @cash.comment)
          format.html { redirect_to [:admin, @user], notice: 'Cash was successfully created.' }
          format.json { render json: @cash, status: :created, location: @cash }
        else
          @cash.errors.add(:debit, 'Сумма не должна равняться 0')

          format.html { render action: "new" }
          format.json { render json: @cash.errors, status: :unprocessable_entity }
        end
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
