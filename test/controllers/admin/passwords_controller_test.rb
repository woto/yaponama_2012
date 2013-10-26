# encoding: utf-8

require 'test_helper'

class Admin::PasswordsControllerTest < ActionController::TestCase

  test 'Амдинистратор может изменить пароль покупателю' do
    # TODO позже разобраться с паравами
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    otto = somebodies(:otto)
    patch :update, :id => otto.id, user: { password: '9i8B*3', password_confirmation: '9i8B*3' }
    assert_not_equal otto.password_digest, somebodies(:otto).reload.password_digest
    assert_response :redirect
    assert_equal 'Пароль был успешно изменен.', flash[:success]
    # TODO пользователь попадает на правильную страницу
  end

end
