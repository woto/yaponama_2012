# encoding: utf-8
#
require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase

  test 'Пароль может поменять только аутентифицированный пользователь самому себе' do
    skip
  end

  test 'Проверка полей формы' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    get :edit
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
  end

  test 'Проверка отправки не заполненной формы' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    patch :update, user: { password: '', password_confirmation: '' }
    assert_equal ["не может быть пустым", "недостаточной длины (не может быть меньше 6 символа)"],
      assigns(:user).errors[:password]
    assert_equal ["не может быть пустым", "не совпадает со значением поля Пароль"],
      assigns(:user).errors[:password_confirmation]
  end

  test 'После успешной смены пароля пароль пользователя должен измениться' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    otto = somebodies(:otto)
    patch :update, user: { password: '9i8B*3', password_confirmation: '9i8B*3' }
    assert_not_equal otto.password_digest, somebodies(:otto).reload.password_digest
    assert_response :redirect
    assert_equal 'Пароль был успешно изменен.', flash[:attention]
    # TODO пользователь попадает на правильную страницу
  end

end
