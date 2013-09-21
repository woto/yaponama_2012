# encoding: utf-8
require 'test_helper'

class AccountTransactionTest < ActiveSupport::TestCase
  test 'Проверяем набор полей таблицы' do
    assert_equal [ "id", "account_id", "creator_id", "product_transaction_id", "comment", "debit_before", "debit_after", "credit_before", "credit_after", "created_at" ].sort, AccountTransaction.column_names.sort
  end

  test 'Проверяем, чтобы присвоенные числа приводились к правильному типу' do
    at = AccountTransaction.new(debit: 5)
    assert_instance_of BigDecimal, at.debit
  end

end
