# encoding: utf-8
#
require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test 'Нельзя обращаться ни к debit, ни к credit напрямую у account' do
    stan = somebodies(:stan)
    assert_raises( RuntimeError ) { stan.account.debit = 5 }
    assert_raises( RuntimeError ) { stan.account.credit = 5 }
  end

end
