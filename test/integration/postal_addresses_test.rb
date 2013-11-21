# encoding: utf-8
#
require 'test_helper'

class PostallAddressesTest < ActionDispatch::IntegrationTest

  test "Использовал чтобы разобраться в IntegrationTest и fixtures" do
    skip
    Capybara.reset!
    visit '/user/postal_addresses/new'

    find("#postal_address_postcode").set('123456')
    find("#postal_address_region").set('Регион')
    find("#postal_address_city").set('Город')
    find("#postal_address_street").set('Улица')
    find("#postal_address_house").set('Дом')
    find("#postal_address_room").set('Квартира')

    find('#new_postal_address').find('input[type=submit]').click
  end

  test 'Проверяем чекбокс и отображение поля ввода номера дома до/после нажатия на кнопку "отдельно стоящее здание"' do
    Capybara.reset!
    visit '/user/postal_addresses/new'

    assert has_css?('[name="postal_address[room]"]', visible: true)
    assert !(all('[name="postal_address[stand_alone_house]"]', visible: false).last.checked?)

    find("[rel='button-stand-alone-house']").click

    assert has_css?('[name="postal_address[room]"]', visible: false)
    assert all('[name="postal_address[stand_alone_house]"]', visible: false).last.checked?
  end


end
