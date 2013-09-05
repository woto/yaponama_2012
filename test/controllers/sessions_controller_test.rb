# encoding: utf-8

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test 'Контроллер не должен отдавать никаких странице пользователям с ролью не guest. Кроме выхода' do
    skip
  end

  test 'Форма входа с помощью номера телефона' do
    get :new, {with: 'phone'}
    assert_select "input[name='session[value]']"
    assert_select  "input[name='session[password]']"
    assert_select  "input[name='session[mobile]']"
  end

  test 'Форма входа с помощью e-mail' do
    get :new, {with: 'email'}
    assert_select "input[name='session[value]']"
    assert_select  "input[name='session[password]']"
  end

  test 'Вход с помощью номера телефона. Поля не заполнены' do
    post :create, with: 'phone', session: {value: '', password: ''}
    assert_equal ["не может быть пустым"], assigns(:session).errors[:value]
    assert_equal ["не может быть пустым"], assigns(:session).errors[:password]
  end

  test 'Вход с помощью e-mail. Поля не заполнены' do
    post :create, with: 'email', session: {value: '', password: ''}
    assert_equal ["не может быть пустым"], assigns(:session).errors[:value]
    assert_equal ["не может быть пустым"], assigns(:session).errors[:password]
  end

  test 'Мобильный номер телефона указан в неверном формате.' do
    post :create, with: 'phone', session: {value: '123', password: '123', mobile: true}
    assert_equal ["имеет неверное значение"], assigns(:session).errors[:value]
  end

  test 'Городской номер телефона указан в произвольном формате.' do
    post :create, with: 'phone', session: {value: '123', password: '123', mobile: false}
    assert assigns(:session).errors[:value].blank?
  end

  test 'E-mail указан в неверном формате' do
    post :create, with: 'email', session: {value: 'abc', password: ''}
    assert_equal ["имеет неверное значение"], assigns(:session).errors[:value]
  end

  test "Если админ с правильно выставленным auth_token делаем delete :destroy. То auth_token должен сброситься и его должно редиректнуть" do
    cookies['auth_token'] = users(:first_admin).auth_token
    delete :destroy
    assert_nil cookies['auth_token']
    assert_equal response.code, '302'
  end

  test 'Если стоит галка запомнить меня, то должны запомнить на X времени' do
    skip
  end

  test 'Если не стоит галка запомнить, то забываем после закрытия браузера' do
    skip
  end

  test 'Т.к. допустимо иметь несколько одинаковых phone или email, то вход должен осуществиться в соответствии с паролем учетной записи' do
    skip
  end

  test 'Проверять with(?)' do
    skip
  end
end
