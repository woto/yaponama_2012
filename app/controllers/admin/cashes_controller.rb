#encoding: utf-8

class Admin::CashesController < ApplicationController
  include Admin::Admined
  
  before_action {@meta_title = "Внесение средств на счет"}

  def new
    @cash = Cash.new
  end

  def create
    @cash = Cash.new(cash_params)
    @cash.user = @user

    respond_to do |format|
      if @cash.save
          format.html { redirect_to [:admin, @user], success: "Успешно внесено #{view_context.number_to_currency(@cash.debit)}" }
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
    # TODO Запретить credit
  end

end
