# encoding: utf-8
#
class AccountTransaction < ActiveRecord::Base
  include BelongsToCreator
  belongs_to :product_transaction
  belongs_to :account

  before_save :update_account

  attr_accessor :debit, :credit

  def credit=(val)
    @credit = val.to_d
  end

  def debit=(val)
    @debit = val.to_d
  end

  def update_account

    if credit
      account.send(:write_attribute, :credit, account.credit + credit)
    end

    if debit
      account.send(:write_attribute, :debit, account.debit + debit)
    end

    #self.accountable_id = account.accountable_id
    #self.accountable_type = account.accountable_type

    self.somebody_id_before = account.somebody_id
    self.somebody_id_after = account.somebody_id

    self.credit_before = account.credit_was
    self.credit_after = account.credit

    self.debit_before = account.debit_was
    self.debit_after = account.debit

    account.save!

  end

end
