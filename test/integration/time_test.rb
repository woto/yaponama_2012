# encoding: utf-8
#
require 'test_helper'

class TimeTest < ActionDispatch::IntegrationTest

  test 'Если у пользователя вообще пустой cached_russian_time_zone_auto_id (Например новый пользователь)' do
    get '/'
    assert_select '#anton-time', :text => '2012-04-12 07:45:38 +0400'
  end

  test 'Если у пользователя выставлен неверный cached_russian_time_zone_auto_id (например неверная дата)' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get '/'
    assert_select '#anton-time', :text => '2012-04-12 07:45:38 +0400'
  end

  test 'Если у пользователя выставлено use_auto_russian_time_zone в true, и значение cached_russian_time_zone_auto_id верное' do
    cookies['auth_token'] = somebodies(:max).auth_token
    get '/'
    assert_select '#anton-time', :text => '2012-04-12 12:45:38 +0900'
  end

  test 'Если у пользователя выставлено use_auto_russian_time_zone в true, и значение cached_russian_time_zone_auto_id верное, но такой часовой пояс отсутствует в России' do
    cookies['auth_token'] = somebodies(:otto).auth_token
    get '/'
    assert_select '#anton-time', :text => '2012-04-12 07:45:38 +0400'
  end

end
