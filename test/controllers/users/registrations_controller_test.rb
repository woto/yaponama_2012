require 'test_helper'

class Users::RegistrationsControllerTest < ActionController::TestCase

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'У успешно зарегистрированного пользователя должна быть роль user' do
    assert_difference -> {User.count} do
      post :create, {user: {email: 'new@example.com', password: '123123123', password_confirmation: '123123123'}}
      assert_equal 'user', User.last.role
    end
  end

  test 'Если у меня нет товаров в корзине, то после регистрации я должен попасть в личный кабинет' do
    assert_difference -> {User.count}, 0 do
      post :create, {user: {email: 'fake@example.com', password: '12345678', password_confirmation: '12345678'}}, {guest_user_id: users(:guest_without_products).id}
    end
    assert_redirected_to user_path
  end

  test 'Если у меня есть товары в корзине, то после регистрации я должен попасть в корзину' do
    assert_difference -> {User.count}, 0 do
      post :create, {user: {email: 'fake@example.com', password: '12345678', password_confirmation: '12345678'}}, {guest_user_id: users(:guest).id}
      assert_redirected_to user_cart_index_path
    end
  end

end
