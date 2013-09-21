#encoding: utf-8

class Cash

  include ActiveModel::Model
  attr_accessor :debit, :comment, :user
  validates :debit, presence: true, numericality: true
  validates :user, presence: true

  validate :debit do
    if debit.to_s.to_d == 0
      errors.add :debit, 'сумма не должна равняться 0'
    end
  end

  def save
    if valid?
      return true if @user.account.account_transactions.create(:debit => debit, :comment => comment)
    end
  end

end
