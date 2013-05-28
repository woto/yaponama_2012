# encoding: utf-8

require 'test_helper'

class PostallAddressesTest < ActionDispatch::IntegrationTest

  test "Использовал чтобы разобраться в IntegrationTest и fixtures" do
    skip "Позже"
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

end
