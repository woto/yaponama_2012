require 'test_helper'

class User::Orders::DeliveriesControllerTest < ActionController::TestCase

  test 'Если ipgeobase_name Москва, то is_moscow по-умолчанию true' do
    sign_in(users(:user))
    @request.remote_addr = '176.195.87.131'
    get :new
    assert_equal true, assigns(:resource).new_postal_address.is_moscow
  end

  test 'Если ipgeobase_name не Москва, то is_moscow по-умолчанию не true' do
    sign_in(users(:user))
    get :new
    assert_not_equal true, assigns(:resource).new_postal_address.is_moscow
  end

  test 'Если у пользователя уже имеется адрес, то он должен быть доступен для выбора в select' do
    sign_in(users(:user_with_postal_address_and_products_incart))
    get :new
    assert_select '#orders_delivery_form_postal_address_id' do
      assert_select 'option[value=""]'
      assert_select 'option[value="-1"]', text: 'Добавить новый адрес'
      assert_select 'option:match("value", ?)', postal_addresses(:user_with_postal_address_and_products_incart).id.to_s
    end
  end

  test 'Если у нас не заполнены name, email и телефон, то они должны быть доступны для ввода' do
    guest = users(:guest)
    guest.products.create!(catalog_number: '1', brand: brands(:mazda), quantity_ordered: 1, buy_cost: 1, sell_cost: 1, status: 'inorder')
    sign_in(guest)
    get :new
    assert_select 'input#orders_delivery_form_user_form_attributes_email'
    assert_select 'input#orders_delivery_form_user_form_attributes_name'
    assert_select 'input#orders_delivery_form_user_form_attributes_phone'
  end

  test 'Если у нас заполнены name, email и телефон, то они не доступны для изменения' do
    user = users(:user)
    user.update!(phone: '+7 (123) 456-78-90', name: 'Покупатель')
    sign_in(user)
    get :new
    assert_select '.form-control-static', 'user@example.com'
    assert_select '#orders_delivery_form_user_form_attributes_email', value: 'user@example.com'
    assert_select '.form-control-static', 'Покупатель'
    assert_select '#orders_delivery_form_user_form_attributes_name', value: 'Покупатель'
    assert_select '.form-control-static', '+7 (123) 456-78-90'
    assert_select '#orders_delivery_form_user_form_attributes_phone', value: '+7 (123) 456-78-90'
  end

  test 'После создания заказа гость должен превратиться в пользователя, ему должен сгенерироваться пароль, отправиться письмо об авторегистрации и письмо - уведомление об оформлении заказа' do
    flunk
  end

  test 'После оформления заказа пользователю должно отправиться письмо - уведомление об оформлении заказа' do
    flunk
  end

end
