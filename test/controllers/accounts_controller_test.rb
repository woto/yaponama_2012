# encoding: utf-8

require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test 'Из-за того что меняю отображение профиля и кое-что удаляю, хочу быть уверенным, что она по-прежнему будет работать, пока к ней не вернусь.' do
    assert_routing('/user/accounts/transactions', {controller: "accounts", action: "transactions"})
  end
end
