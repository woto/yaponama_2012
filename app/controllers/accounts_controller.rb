# encoding: utf-8
#
class AccountsController < ApplicationController
  # include GridAccount

  def transactions
    # Перенес из account_transactions_controller
    # Остальная часть контроллера из админ
    @transactions = AccountTransaction.all

    if @user
      @transactions = @user.account.account_transactions
      klass = @user.class
    end

    if @supplier
      @transactions = @supplier.account.account_transactions
      klass = @supplier.class
    end

    @transactions = @transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html { render 'profileables/transactions' }
      format.json { render json: @transactions }
    end

  end

  private

  def set_resource_class
    @resource_class = Account
  end

end
