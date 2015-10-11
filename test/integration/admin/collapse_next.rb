# encoding: utf-8
#
require 'test_helper'

class Admin::CollapseNextTest < ActionDispatch::IntegrationTest

  test 'Проверка работы collapse-next функционала' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    user = somebodies(:first_user)
    postal_address = postal_addresses(:first_user)
    visit "/admin/users/#{user.id}/postal_addresses/#{postal_address.id}/edit"

    # Вначале блок свернут
    assert page.has_css?('[rel="acceptance-test"]', visible: :hidden)

    # Разворачиваем
    find("[rel=collapse-next] span").click

    # Потом соответственно развернут
    assert page.has_css?('[rel="acceptance-test"]')
  end
end
