class Transaction < ActiveRecord::Base
  attr_accessible :left_money, :right_money, :left_real, :right_real, :left_account, :right_account
  attr_accessible :left_account_id, :right_account_id
  belongs_to :left_account, :inverse_of => :transactions, :class_name => "Account"
  belongs_to :right_account, :inverse_of => :transactions, :class_name => "Account"
  belongs_to :documentable, :polymorphic => true

  before_save :update_money


  def update_money

    if left_account
      if left_real
        left_account.money_available = left_account.money_available + left_money
      else
        left_account.money_locked = left_account.money_locked + left_money
      end

      left_account.save
    end


    if right_account
      if right_real
        right_account.money_available = right_account.money_available + right_money
      else
        right_account.money_locked = right_account.money_locked + right_money
      end

      right_account.save
    end

  end
end
