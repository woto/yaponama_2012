require 'test_helper'

class DeliveriesTest < ActionDispatch::IntegrationTest

  test 'Не заполняем ни одного поля' do
    Capybara.reset!
    visit '/deliveries'
    click_button 'Рассчитать'
    assert_selector('#order_delivery_new_postal_address_attributes_street + span > b', text: 'не может быть пустым')
    assert_selector('#order_delivery_new_postal_address_attributes_house + span > b', text: 'не может быть пустым')
  end

  test 'Вводим новый адрес' do
    Capybara.reset!
    visit '/deliveries'
    fill_in 'order_delivery[new_postal_address_attributes][street]', with: 'Ленинский проспект'
    fill_in 'order_delivery[new_postal_address_attributes][house]', with: '1'
    click_button 'Рассчитать'
    assert has_text?('Проверить другой адрес')
  end

  test 'После успешного ввода нового адреса у нас есть возможность ввести новый или выбрать уже имеющийся' do
    Capybara.reset!
    visit '/deliveries'
    fill_in 'order_delivery[new_postal_address_attributes][street]', with: 'Ленинский проспект'
    fill_in 'order_delivery[new_postal_address_attributes][house]', with: '1'
    click_button 'Рассчитать'
    click_link 'Проверить другой адрес'

    # По-умолчанию выбран radio с select'ом для выбора имеющегося адреса
    assert has_checked_field? 'order_delivery_postal_address_type_old'

    # Есть возможность выбора между вводом нового адреса или выбором имеющегося
    assert_selector '#order_delivery_postal_address_type_new'
    assert_selector '#order_delivery_postal_address_type_old'

    # Есть select с возможностью выбора имеющегося
    assert_selector '#order_delivery_old_postal_address_id'

    # Выбираем radio для ввода нового адреса
    choose 'order_delivery_postal_address_type_new'

    # Теперь появились поля для ввода нового
    assert_selector '#order_delivery_new_postal_address_attributes_street'
    assert_selector '#order_delivery_new_postal_address_attributes_house'

  end

end


