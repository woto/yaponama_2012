# encoding: utf-8
#
require 'test_helper'

class Admin::ConfirmsControllerTest < ActionController::TestCase

  test 'Отправить ссылку для подтверждения может только seller' do
    skip
  end

  test 'Проверить правильность flash и редиректа назад' do
    skip
  end

  test 'Продавцы могут запросить ссылку и пин код для любого контакта' do
    skip
  end

  test 'Отправляем код подтверждения' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    xhr :get, :ask, resource_class: "Phone", id: phones(:first_user)
    assert_redirected_to view_admin_confirm_phone_path(phones(:first_user))
  end

  test 'Пробуем отправить код подтверждения на уже подтвержденный контакт' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    xhr :get, :ask, resource_class: "Phone", id: phones(:otto2)
    assert_redirected_to admin_user_path(somebodies(:otto))
  end

  test 'Результат, полученный в результате отправки кода подтверждения пользователю' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    xhr :get, :view, resource_class: "Phone", id: phones(:first_user)
    assert_match "alert(\"Код подтверждения отправлен на +7 (123) 123-12-31\");\n", response.body
  end

end
