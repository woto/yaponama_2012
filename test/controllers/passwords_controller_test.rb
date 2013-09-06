# encoding: utf-8

require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase

  test 'Пароль может поменять только аутентифицированный пользователь самому себе' do
    skip
  end

  test 'Проверка полей формы' do
    cookies['auth_token'] = users(:otto).auth_token
    get :edit
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
  end

  test 'Проверка отправки не заполненной формы' do
    cookies['auth_token'] = users(:otto).auth_token
    patch :update, user: { password: '', password_confirmation: '' }
    assert_equal ["не может быть пустым", "недостаточной длины (не может быть меньше 6 символов)"],
      assigns(:user).errors[:password]
    assert_equal ["не может быть пустым", "не совпадает с подтверждением"],
      assigns(:user).errors[:password_confirmation]
  end

end
