# encoding: utf-8
#
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
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    delete :destroy
    assert_nil cookies['auth_token']
    assert_equal '302', response.code
  end

  test 'Т.к. допустимо иметь несколько одинаковых phone или email, то вход должен осуществиться в соответствии с паролем учетной записи' do
    skip
  end

  test 'Если у пользователя установлена опция logout_from_other_places, то после входа должен быть новый auth_token' do
    user = somebodies(:otto)
    auth_token = user.auth_token
    phone = '+7 (555) 555-55-55'
    password = '5555555555'
    post :create, { session: {value: phone, password: password, mobile: true }, with: 'phone' }
    new_auth_token = user.reload.auth_token
    assert_not_equal auth_token, new_auth_token
    assert_equal cookies['auth_token'], new_auth_token
  end

  test 'Если у пользователя не установлена опция logout_from_other_places, то после входа auth_token должен остаться прежним' do
    user = somebodies(:stan)
    auth_token = user.auth_token
    phone = '+7 (333) 333-33-33'
    password = '3333333333'
    post :create, { session: {value: phone, password: password, mobile: true }, with: 'phone' }
    new_auth_token = user.reload.auth_token
    assert_equal auth_token, new_auth_token
    assert_equal cookies['auth_token'], new_auth_token
  end

  test 'Если пользователь уже вошел на сайт, то при попытке запроса страниц, у которых only_not_authenticated мы должны увидеть уведомление, что вход уже осуществлен для ролей admin, manager, user' do
    cookies['auth_token'] = somebodies(:stan).auth_token
    get :show
    assert_equal 'Вы уже вошли на сайт.', flash[:attention]
  end

  test 'И наоборот при попытке доступа не аутентифицированным пользователем к страницам, у которых only_authenticated мы должны увидеть уведомление, о необходимости входа для ролей guest' do
    delete :destroy
    assert_equal 'Пожалуйста войдите на сайт.', flash[:attention]
  end

  test 'Если гость вошел под пользовательской учетной записью или восстановил пароль, то необходимо передать данные (профили, заказы и т.д.) пользователю.' do
    profile = profiles :sending1
    phone = phones :sending1
    email = emails :sending1
    name = names :sending1
    passport = passports :sending1
    talk = talks :sending1
    postal_address = postal_addresses :sending1
    company = companies :sending1
    car = cars :sending1
    order = orders :sending1
    product = products :sending1

    sending1 = somebodies :sending1
    receiving1 = somebodies :receiving1
    cookies[:auth_token] = sending1.auth_token
    post :create, "session" => {"mobile"=>"0", "value"=>"receiving1", "password"=>"receiving1"}, with: 'phone'

    assert_equal receiving1, profile.reload.somebody
    assert_equal receiving1, phone.reload.somebody
    assert_equal receiving1, email.reload.somebody
    assert_equal receiving1, name.reload.somebody
    assert_equal receiving1, passport.reload.somebody
    assert_equal receiving1, talk.reload.somebody
    assert_equal receiving1, postal_address.reload.somebody
    assert_equal receiving1, company.reload.somebody
    assert_equal receiving1, car.reload.somebody
    assert_equal receiving1, order.reload.somebody
    assert_equal receiving1, product.reload.somebody
  end

  test 'Выход пользователя' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    delete :destroy

    assert_equal nil, cookies['auth_token']
    assert_equal nil, cookies['role']
  end

end
