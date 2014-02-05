# encoding: utf-8
#
require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  test 'Менеджер перегенерировывает auth_token покупателю' do
    # TODO это может сделать только продавец
    first_admin = somebodies(:first_admin)
    stan = somebodies(:stan)
    old_auth_token = stan.auth_token
    cookies['auth_token'] = first_admin.auth_token

    delete :logout_from_all_places, id: stan.id

    new_auth_token = stan.reload.auth_token
    assert_not_equal new_auth_token, old_auth_token
    assert_equal new_auth_token.size, 22
    assert_equal 'Вы разлогинили пользователя со всех компьютеров. Теперь ему потребуется заново войти на сайт.', flash[:success]
  end

  test 'Администратор может создавать новых пользователей' do
    # TODO это может сделать только администратор
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    assert_difference 'User.count' do
      post :create, :user => {:id => ''}
    end
    assert_redirected_to admin_user_path(User.last)
    #assert_equal "User был успешно создан.", flash[:success]
  end

end
