#encoding: utf-8

class AccountTransaction < ActiveRecord::Base
  include BelongsToCreator
  belongs_to :product_transaction
  belongs_to :account

  before_save :update_account

  attr_accessor :debit, :credit

  def update_account

    if credit
      account.credit += credit.to_d
    end

    if debit
      account.debit += debit.to_d
    end

    self.credit_before = account.credit_was
    self.credit_after = account.credit

    self.debit_before = account.debit_was
    self.debit_after = account.debit

    account.save

  end

end
