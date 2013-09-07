# encoding: utf-8

require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  test 'Менеджер перегенировывает auth_token покупателю' do
    # TODO это может сделать только продавец
    first_admin = users(:first_admin)
    stan = users(:stan)
    old_auth_token = stan.auth_token
    cookies['auth_token'] = first_admin.auth_token

    delete :logout_from_all_places, user_id: stan.id

    new_auth_token = stan.reload.auth_token
    assert_not_equal new_auth_token, old_auth_token
  end

end
