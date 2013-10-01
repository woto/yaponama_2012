# encoding: utf-8

require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'Пользователь перегенерировывает auth_token (Делает выход со всех компьютеров)' do
    auth_token = users(:otto).auth_token
    cookies['auth_token'] = auth_token

    delete :logout_from_all_places

    assert_not_equal auth_token, users(:otto).reload.auth_token
    assert_equal 'Вы успешно вышли со всех компьютеров, где использовалась ваша учетная запись.', flash[:success]
  end

end
