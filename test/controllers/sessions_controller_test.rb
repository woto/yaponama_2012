# encoding: utf-8

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "Проверка входа по номеру телефона" do
    post :create, {login: '1111111111', password: '1111111111'}
    assert_equal flash[:notice], "Вы успешно вошли."
  end

  test "Проверка входа по e-mail" do
    post :create, {login: 'foo@example.com', password: '1111111111'}
    assert_equal flash[:notice], 'Вы успешно вошли.'
  end

  test 'Проверка ошибочного ввода пароля' do
    post :create, {login: '1111111111', password: '1'}
    assert_equal flash[:alert], 'Пара e-mail/телефон и пароль не найдены.'
  end

  test "Если админ с правильно выставленным auth_token делаем delete :destroy. То auth_token должен сброситься и его должно редиректнуть" do
    cookies['auth_token'] = users(:first_admin).auth_token
    delete :destroy
    assert_nil cookies['auth_token']
    assert_equal response.code, '302'
  end

end
