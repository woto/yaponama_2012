class Account < ActiveRecord::Base
  attr_accessible :money_available, :money_locked, :name
  belongs_to :accountable, :polymorphic => true
  has_many :transactions, :inverse_of => :account

  #before_save :create_transaction

  #def create_transaction
  #  if changes[:money_available] && changes[:money_locked]
  #    raise 'Unable to make both changes in account'
  #  end

  #  if changes[:money_available]
  #    transactions.build(:account => self, :money => changes[:money_available][1])
  #  end

  #  if changes[:money_locked]
  #    transactions.build(:account => self, :money => changes[:money_locked][1])
  #  end
  #end

end
