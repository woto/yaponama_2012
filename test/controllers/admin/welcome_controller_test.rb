# encoding: utf-8
#
require 'test_helper'

class Admin::WelcomeControllerTest < ActionController::TestCase

  test 'Попытка доступа к административной части аутентифицированным пользователем (user) не должна быть успешной' do
    cookies[:auth_token] = somebodies(:first_user).auth_token
    get :index
    assert_equal 'У вас нет доступа к этой части сайта.', flash[:attention]
    assert_redirected_to controller: '/welcome', action: 'index'
  end

end
