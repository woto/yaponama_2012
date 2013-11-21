# encoding: utf-8
#
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test 'Проверка отображения ссылок для подтверждения у пользователя' do

    cookies['auth_token'] = somebodies(:otto).auth_token

    get :index

    assert_select '.confirm-phone', count: 1 do |link|
      assert_select "a[href=?]", /\/user\/phones\/\d+\/confirm\/view/
      assert_select "a", text: '+7 (111) 111-11-11'
    end

    assert_select '.confirm-email', count: 1 do |link|
      assert_select "a[href=?]", /\/user\/emails\/\d+\/confirm\/view/
      assert_select "a", text: 'foo@example.com'
    end

    #assert_match /\/user\/emails\/\d+\/confirm/, find('a', text: 'Подтвердить')['href']

  end

  test "Если посетитель запрашивает страницу с несуществующим auth_token'ом, то он должен быть перенаправлен на главную страницу и auth_token должен быть сброшен." do

    cookies['auth_token'] = 'auth_token_of_nonexistent_user'
    get :index
    assert_redirected_to('/')
    assert_nil cookies['auth_token']
  end

  test "Если посетитель впервые посещает сайт, то в базе должен добавиться пользователь. А клиенту назначен auth_token соответствующий новой записи. creation_reason пользователя должен быть session" do

    assert_difference('User.count'){get :index}
    assert_not_nil cookies['auth_token']
    user = User.last
    assert_equal user.auth_token, cookies['auth_token']
    assert_equal 'session', user.creation_reason
  end

  test 'Сделать проверку @meta_...' do

  end

end
