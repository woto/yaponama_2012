class Account < ActiveRecord::Base
  attr_accessible :name, :debit, :credit, :accountable_id, :accountable_type
  belongs_to :accountable, :polymorphic => true
  has_many :transactions, :inverse_of => :account

  validates :credit, :numericality => true
  validates :debit, :numericality => true

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
