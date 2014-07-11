# encoding: utf-8
#
require 'test_helper'

class BreadcrumbTest < ActionDispatch::IntegrationTest
  #fixtures :somebodies

  test 'Дом -> Личный кабинет -> Контактные лица' do
    cookies[:auth_token] = somebodies(:otto).auth_token
    get_via_redirect '/user/profiles'
    assert_select '.breadcrumb' do
      assert_select 'li', 3
    end
  end

  test 'Дом -> Личный кабинет -> Контактные лица -> Контактное лицо' do
    cookies[:auth_token] = somebodies(:otto).auth_token
    get_via_redirect "/user/profiles/#{profiles(:otto).id}"
    assert_select '.breadcrumb' do
      assert_select 'li', 4
    end

  end

  test 'Дом -> Личный кабинет' do
    cookies[:auth_token] = somebodies(:otto).auth_token
    get_via_redirect "/user"
    assert_select '.breadcrumb' do
      assert_select 'li', 2
    end
  end

end
