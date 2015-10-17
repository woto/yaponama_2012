require 'test_helper'

class Users::SessionsControllerTest < ActionController::TestCase

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'Мы можем залогиниться зарегистрированным пользователем' do
    post :create, {user: {email: 'user_without_products@example.com', password: '12345678'}}
    assert_redirected_to user_path
    assert_equal 'Вход в систему выполнен.', flash[:notice]
  end

  test 'Мы не можем залогиниться с неправильным паролем' do
    post :create, {user: {email: 'user@example.com', password: '1'}}
    assert_response :success
    assert_equal 'Неверные email или пароль.', flash[:alert]
  end

  test 'Мы не можем залогиниться с неправильным email' do
    post :create, {user: {email: '', password: '12345678'}}
    assert_response :success
    assert_equal 'Неверные email или пароль.', flash[:alert]
  end

  test 'Если стоит галка запомнить меня' do
    post :create, {user: {email: 'user_without_products@example.com', password: '12345678', remember_me: '1'}}
    assert_redirected_to user_path
    assert_equal 'Вход в систему выполнен.', flash[:notice]
    assert cookies['remember_user_token']
  end

  test 'Если я админ, то после входа под своей учетной записью я должен попасть так же в личный кабинет' do
    assert_difference -> {User.count}, -1 do
      post :create, {user: {email: 'admin@example.com', password: '12345678'}}, {guest_user_id: users(:guest_without_products).id}
    end
    assert_redirected_to user_path
  end

  test 'Если у меня нет товаров в корзине, то после входа под своей учетной записью я должен попасть в личный кабинет' do
    assert_difference -> {User.count}, -1 do
      post :create, {user: {email: 'user_without_products@example.com', password: '12345678'}}, {guest_user_id: users(:guest_without_products).id}
    end
    assert_redirected_to user_path
  end

  test 'Если у меня нет товаров в корзине, но были добавлены под моей учетной записью, то после входа я должен попасть в корзину' do
    assert_difference -> {User.count}, -1 do
      post :create, {user: {email: 'user@example.com', password: '12345678'}}, {guest_user_id: users(:guest_without_products).id}
      assert_redirected_to user_cart_index_path
    end
  end

  test 'Если у меня есть товары в корзине, то после входа под своей учетной записью я должен попасть в корзину' do
    assert_difference -> {User.count}, -1 do
      post :create, {user: {email: 'user@example.com', password: '12345678'}}, {guest_user_id: users(:guest).id}
      assert_redirected_to user_cart_index_path
    end
  end

end
