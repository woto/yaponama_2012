require 'test_helper'

class User::Orders::DeliveriesTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'После щелчка на stand_alone_house поле для ввода квартиры должно спрятаться' do
    capybara_sign_in 'user@example.com', '12345678'
    visit new_user_order_path
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_room'
    check 'Отдельно стоящее здание'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_room', visible: :hidden
  end

  test 'После щелчка на is_moscow должны спрятаться поля связанные с указанием город' do
    capybara_sign_in 'user@example.com', '12345678'
    visit new_user_order_path
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_postcode'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_region'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_city'
    check 'г. Москва'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_postcode', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_region', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_city', visible: :hidden
  end

  test 'Если у нас уже имеется адрес, то показываем элемент для выбора адреса, поля для добавления адреса по-умолчанию скрыты' do
    capybara_sign_in 'user_with_postal_address_and_products_incart@example.com', '12345678'
    visit new_user_order_path
    assert has_field?('orders_delivery_form_postal_address_id')
    assert has_select? 'orders_delivery_form_postal_address_id', selected: ''
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_is_moscow', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_postcode', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_region', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_city', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_street', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_house', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_stand_alone_house', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_room', visible: :hidden
  end

  test 'Если мы выбираем добавление нового адреса, то должны появиться поля для собственно его ввода' do
    capybara_sign_in 'user_with_postal_address_and_products_incart@example.com', '12345678'
    visit new_user_order_path
    assert has_field?('orders_delivery_form_postal_address_id')
    select 'Добавить новый адрес', from: 'orders_delivery_form_postal_address_id'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_is_moscow'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_postcode'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_region'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_city'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_street'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_house'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_stand_alone_house'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_room'
  end

  test 'Если мы выбираем имеющийся адрес, то поля для добавления нового адреса скрываются' do
    capybara_sign_in 'user_with_postal_address_and_products_incart@example.com', '12345678'
    visit new_user_order_path
    assert has_field?('orders_delivery_form_postal_address_id')
    select '123456, 1, 1, 1, 1, 1', from: 'orders_delivery_form_postal_address_id'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_is_moscow', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_postcode', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_region', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_city', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_street', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_house', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_stand_alone_house', visible: :hidden
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_room', visible: :hidden
  end

  test 'Если у покупателя еще нет ни одного адреса, то показываем поля для ввода адреса. Элемент управления выбора старый/новый адрес при этом не показываем' do
    capybara_sign_in 'user@example.com', '12345678'
    visit new_user_order_path
    assert has_css? 'input#orders_delivery_form_postal_address_id[type="hidden"][value="-1"]', visible: false
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_is_moscow'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_postcode'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_region'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_city'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_street'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_house'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_stand_alone_house'
    assert has_field? 'orders_delivery_form_new_postal_address_attributes_room'
  end

end
