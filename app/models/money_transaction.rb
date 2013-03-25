#encoding: utf-8

class MoneyTransaction < ActiveRecord::Base
  belongs_to :product_transaction
  belongs_to :account

  before_save :update_account

  def update_account

    # TODO Если внести 0, то транзация запишется, чего не хочется
    # ps. еще столкнусь на странице внесения средств.

    if self.changes[:credit]
      self.account.credit += credit
    end

    if self.changes[:debit]
      self.account.debit += debit
    end

    if credit
      self.credit_log = "#{self.account.credit_was} #{credit>0 ? "+" : "-"} #{credit.abs} = #{self.account.credit} р."
    else
      self.credit_log = "#{self.account.credit} р."
    end

    if debit
      self.debit_log = "#{self.account.debit_was} #{debit>0 ? "+" : "-" } #{debit.abs}  = #{self.account.debit} р."
    else
      self.debit_log = "#{self.account.debit} р."
    end

    self.account.save

  end

end
