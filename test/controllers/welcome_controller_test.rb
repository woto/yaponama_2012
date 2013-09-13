# encoding: utf-8

require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
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

  end

end
