require 'test_helper'

class Users::PasswordsControllerTest < ActionController::TestCase

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'Проверяем, что после перехода по ссылке восстановления пароля форма заполнена правильно' do
    user = users(:user)
    token = user.send(:set_reset_password_token)
    get :edit, reset_password_token: token
    assert_select "[name='user[password]']"
    assert_select "[name='user[password_confirmation]']"
    assert_select "[name='user[reset_password_token]'][value='#{token}']"
  end

end


