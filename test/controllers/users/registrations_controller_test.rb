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

end
