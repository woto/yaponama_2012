require 'test_helper'

class Users::SessionsControllerTest < ActionController::TestCase

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'Мы можем залогиниться зарегистрированным пользователем' do
    post :create, {user: {email: 'ben@example.com', password: '12345678'}}
    assert_redirected_to user_path
    assert_equal 'Вход в систему выполнен.', flash[:notice]
  end

  test 'Мы не можем залогиниться с неправильным паролем' do
    post :create, {user: {email: 'ben@example.com', password: '1'}}
    assert_response :success
    assert_equal 'Неверные email или пароль.', flash[:alert]
  end

  test 'Мы не можем залогиниться с неправильным email' do
    post :create, {user: {email: '', password: '12345678'}}
    assert_response :success
    assert_equal 'Неверные email или пароль.', flash[:alert]
  end

  test 'Если стоит галка запомнить меня' do
    post :create, {user: {email: 'ben@example.com', password: '12345678', remember_me: '1'}}
    assert_redirected_to user_path
    assert_equal 'Вход в систему выполнен.', flash[:notice]
    assert cookies['remember_user_token']
  end

end
