# encoding: utf-8
#
require 'test_helper'

class Admin::CashesControllerTest < ActionController::TestCase
  test 'Это могуть делать только sellers' do
    skip
  end

  test 'Когда деньги успешно положены на счет, то показываем уведомление attention' do
    first_admin = somebodies(:first_admin)
    cookies['auth_token'] = first_admin.auth_token
    stan = somebodies(:stan)

    xhr :post, :create, 'cash' => { "debit"=>"1.1", "comment"=>"тест" }, user_id: stan.id
    assert_equal 'Успешно внесено 1,10 руб.', flash[:attention]
  end

  test 'Когда деньги положить не удалось, то показываем тот же modal window с ошибкой' do
    first_admin = somebodies(:first_admin)
    cookies['auth_token'] = first_admin.auth_token
    stan = somebodies(:stan)

    xhr :post, :create, 'cash' => { "debit"=>"", "comment"=>"тест" }, user_id: stan.id
    assert response.body.include?('не может быть пустым, не является числом, сумма не должна равняться 0')
    assert_equal nil, flash[:attention]
  end

  

  test 'Кладя на счет деньги убеждаемся в правильности записи транзакций' do
    first_admin = somebodies(:first_admin)
    cookies['auth_token'] = first_admin.auth_token
    stan = somebodies(:stan)

    assert_difference 'AccountTransaction.count' do
      post :create, 'cash' => { "debit"=>"1.1", "comment"=>"тест" }, user_id: stan.id
    end

    at = AccountTransaction.last
    assert_equal stan.account.id, at.account_id
    assert_equal first_admin.id, at.creator_id
    assert_equal nil, at.product_transaction_id
    assert_equal 'тест', at.comment
    assert_equal 0, at.debit_before
    assert_equal 1.1, at.debit_after
    assert_equal 0, at.credit_before
    assert_equal 0, at.credit_after

    # Кладем деньги еще раз

    assert_difference 'AccountTransaction.count' do
      post :create, 'cash' => { "debit"=>"1.01", "comment"=>"тест 2" }, user_id: stan.id
    end

    at = AccountTransaction.last
    assert_equal stan.account.id, at.account_id
    assert_equal first_admin.id, at.creator_id
    assert_equal nil, at.product_transaction_id
    assert_equal 'тест 2', at.comment
    assert_equal 1.1, at.debit_before
    assert_equal 2.11, at.debit_after
    assert_equal 0, at.credit_before
    assert_equal 0, at.credit_after

  end
end
