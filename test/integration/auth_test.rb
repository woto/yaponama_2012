# encoding: utf-8

require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest

  test 'Тестирование google_oauth2' do
    get_via_redirect '/auth/google_oauth2'
    assert User.last.auths.first.present?
    # TODO Потом допишу
  end

  test 'Тестирование facebook' do
    get_via_redirect '/auth/facebook'
  end

  test 'Тестирование vkontakte' do
    get_via_redirect '/auth/vkontakte'
  end

  test 'Тестирование twitter' do
    get_via_redirect '/auth/twitter'
  end

  test 'Тестирование yandex' do
    get_via_redirect '/auth/yandex'
  end

  test 'Тестирование odnoklassniki' do
    get_via_redirect '/auth/odnoklassniki'
  end

  test 'Тестирование mailru' do
    get_via_redirect '/auth/mailru'
  end

end

