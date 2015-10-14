require 'test_helper'

class User::Orders::ShopsControllerTest < ActionController::TestCase

  test 'Находясь на странице оформления заказа в магазин, должно писаться его название и должен присутствовать hidden input' do
    sign_in(users(:user))
    shop_id = deliveries_places(:first).id.to_s
    get :new, {orders_shop_form: {deliveries_place_id: shop_id}}
    assert_select '.form-control-static', 'ул. Красноармейская, д.8, корп. 3, кв. 18'
    assert_select '#orders_shop_form_deliveries_place_id', value: shop_id
  end

end

