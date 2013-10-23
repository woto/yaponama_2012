require 'test_helper'

class CashTest < ActiveSupport::TestCase
  def setup
    @cash = Cash.new
    @cash.somebody = somebodies(:otto)
  end

  test 'Не может быть без пользователя' do
    @cash.somebody = nil
    @cash.debit = 1
    refute @cash.valid?
  end

  test 'Сумма не может быть nil' do
    @cash.debit = nil
    refute @cash.valid?
  end

  test 'Сумма не может быть пустой' do
    @cash.debit = ''
    refute @cash.valid?
  end

  test 'Сумма не может являться не числом' do
    @cash.debit = 'a'
    refute @cash.valid?
  end

  test 'Сумма не может равняться нулю' do
    @cash.debit = 0
    refute @cash.valid?
  end

  test 'Сумма может быть меньше нуля' do
    @cash.debit = -1
    assert @cash.valid?
  end

  test 'Сумма может быть больше нуля' do
    @cash.debit = 1
    assert @cash.valid?
  end

  test 'После вызова сохранения должна создаться транзакция' do
    @cash.debit = 1
    assert_difference 'AccountTransaction.count' do
      @cash.save
    end
  end

end
