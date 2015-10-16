require 'test_helper'

class User::Orders::ShopsControllerTest < ActionController::TestCase

  test 'Находясь на странице оформления заказа в магазин, должно писаться его название и должен присутствовать hidden input' do
    sign_in(users(:user))
    shop_id = deliveries_places(:first).id.to_s
    get :new, {orders_shop_form: {deliveries_place_id: shop_id}}
    assert_select '.form-control-static', 'ул. Красноармейская, д.8, корп. 3, кв. 18'
    assert_select '#orders_shop_form_deliveries_place_id', value: shop_id
  end

  test 'После успешного оформления заказа мы должны редиректнуться в личный кабинет и уведомить пользователя' do
    user = users(:user)
    sign_in(user)
    deliveries_place_id = deliveries_places(:first).id.to_s
    assert_difference -> {user.orders.count} do
      post :create, { "orders_shop_form"=>{
        "user_form_attributes"=>{
          "name"=>"1",
          "email"=>"user@example.com",
          "phone"=>"+7 (111) 111-11-11"},
          "deliveries_place_id" => deliveries_place_id}}
    end
    order = Order.last
    assert flash[:notice], "Заказ № #{order.token} успешно оформлен"
    assert_redirected_to user_path
  end

  test 'После оформления заказа: пользователю улетит письмо о совершении заказа, товары из корзины должны переместиться в заказ и сменить статус' do
    ActionMailer::Base.deliveries.clear
    user = users(:user)
    deliveries_place = deliveries_places(:first)
    sign_in(user)
    assert_difference -> {user.orders.count} do
      post :create, {
        "orders_shop_form"=> {
          "user_form_attributes"=> {
            "name"=>"1",
            "phone"=>"+7 (111) 111-11-11"},
          "deliveries_place_id" => deliveries_place.id.to_s}}
    end
    order = assigns(:resource).order
    assert_empty user.products.incart.where(deliveries_place_id: deliveries_place.id).to_a
    refute_empty order.products.inorder.where(deliveries_place_id: deliveries_place.id).to_a
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['info@avtorif.ru', 'shop@example.com'], ActionMailer::Base.deliveries.last.bcc
  end

end
