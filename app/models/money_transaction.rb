class MoneyTransaction < ActiveRecord::Base
  belongs_to :left_account, :class_name => "Account"
  belongs_to :right_account, :class_name => "Account"
  belongs_to :documentable, :polymorphic => true

  #before_save :update_money
  #after_save :check_orders

  #def check_orders
  #  debugger
  #  puts '1'
  #  #left_account.user.orders:where
  #  #if left_account.user.money_locked - (left_account.user.money_locked / 100 * left_account.user.prepayment_percent) > left_account.user.money_available

  #end

  #def update_money
  #  debugger
  #  puts '1'
  #  return

  #  if left_account
  #    if left_real
  #      left_account.money_available = left_account.money_available + left_money
  #    else
  #      left_account.money_locked = left_account.money_locked + left_money
  #    end

  #    left_account.save
  #  end


  #  if right_account
  #    if right_real
  #      right_account.money_available = right_account.money_available + right_money
  #    else
  #      right_account.money_locked = right_account.money_locked + right_money
  #    end

  #    right_account.save
  #  end

  #end
end
