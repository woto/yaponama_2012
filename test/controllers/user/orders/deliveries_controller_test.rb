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

  test 'Если не выбрали из списка тип используемого адреса: новый или старый, то поле выбора должно содержать ошибку' do
    user = users(:user)
    sign_in(user)
    post :create, { "orders_delivery_form"=> {}}
    assert_equal ['укажите адрес доставки'], assigns(:resource).errors['postal_address_id']
  end

  test 'Если мы выбрали из списка не существующий id адреса' do
    user = users(:user)
    sign_in(user)
    assert_raise do
      post :create, { "orders_delivery_form" => { postal_address_id: '1234567890' }}
    end
  end

  test 'Если мы выбираем существующий адрес и форма содержит ошибку, то new_postal_address должен пересоздаться для возможности добавления нового адреса' do
    guest = users(:guest_with_postal_address)
    postal_address = postal_addresses(:guest_with_postal_address)
    post :create, { "orders_delivery_form": { "postal_address_id": postal_address.id.to_s } }, guest_user_id: guest.id.to_s
    assert_template 'new'
    assert_instance_of PostalAddress, assigns(:resource).new_postal_address
  end

  test 'Если мы пытаемся добавить адрес, но не указали значения полей, то эти поля должны содержать ошибки' do
    user = users(:user)
    sign_in(user)
    post :create, { "orders_delivery_form"=>{
      "user_form_attributes"=>{
        "name"=>"1",
        "email"=>"user@example.com",
        "phone"=>"+7 (111) 111-11-11"},
        "postal_address_id"=>"-1",
        "new_postal_address_attributes"=>{ }}}
    assert_equal ['не может быть пустым'], assigns(:resource).new_postal_address.errors['street']
    assert_equal ['не может быть пустым'], assigns(:resource).new_postal_address.errors['house']
    assert_equal ['не может быть пустым'], assigns(:resource).new_postal_address.errors['room']
    assert_equal ['не может быть пустым'], assigns(:resource).new_postal_address.errors['city']
    assert_equal ['не может быть пустым'], assigns(:resource).new_postal_address.errors['region']
    assert_equal ['не может быть пустым', 'неверной длины (может быть длиной ровно 6 символов)', 'не является числом'], assigns(:resource).new_postal_address.errors['postcode']

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

  test 'После успешного оформления заказа мы должны редиректнуться в личный кабинет и отобразить notice' do
    user = users(:user)
    sign_in(user)
    assert_difference -> {user.orders.count} do
      post :create, { "orders_delivery_form"=>{
        "user_form_attributes"=>{
          "name"=>"1",
          "email"=>"user@example.com",
          "phone"=>"+7 (111) 111-11-11"},
          "postal_address_id"=>"-1",
          "new_postal_address_attributes"=>{
            "is_moscow"=>"1",
            "street"=>"1",
            "house"=>"1",
            "stand_alone_house"=>"1"}}}
    end
    order = Order.last
    assert flash[:notice], "Заказ № #{order.token} успешно оформлен"
    assert_redirected_to user_path
  end

  test 'Если имеются ошибки в заполнении формы, то рендерим new' do
    user = users(:user)
    sign_in(user)
    post :create, { "orders_delivery_form" => { } }
    assert_empty assigns(:resource).user_form.errors['email']
    assert_equal ['не может быть пустым'], assigns(:resource).user_form.errors['name']
    assert_equal ['не может быть пустым'], assigns(:resource).user_form.errors['phone']
    assert_template 'new'
  end

  test 'Если имеются ошибки в заполнении формы гостем, то рендерим new и отображаем ошибки' do
    post :create, { "orders_delivery_form" => {} }
    assert_equal ['не может быть пустым'], assigns(:resource).user_form.errors['email']
    assert_equal ['не может быть пустым'], assigns(:resource).user_form.errors['name']
    assert_equal ['не может быть пустым'], assigns(:resource).user_form.errors['phone']
    assert_template 'new'
  end

  test 'Если у гостя заполнены контактные данные и он пытается оформить заказ, то у этих полей нет ошибок' do
    guest = users(:guest)
    guest.update!(name: '1', phone: '+7 (111) 111-11-11', email: 'email@example.com')
    post :create, { "orders_delivery_form" => {} }, guest_user_id: guest.id
    assert_empty assigns(:resource).user_form.errors['name']
    assert_empty assigns(:resource).user_form.errors['phone']
    assert_empty assigns(:resource).user_form.errors['email']
    assert_template 'new'
  end

  test 'Передавая новые значения контактных данных мы перезаписываем значения в user_form' do
    guest = users(:guest)
    post :create, { "orders_delivery_form" => {
      "user_form_attributes" => {
        name: 'name',
        phone: 'phone',
        email: 'email@example.com'}}},
      guest_user_id: guest.id
    assert_empty assigns(:resource).user_form.errors['name']
    assert_empty assigns(:resource).user_form.errors['phone']
    assert_empty assigns(:resource).user_form.errors['email@example.com']
    assert_equal 'name', assigns(:resource).user_form.name
    assert_equal 'phone', assigns(:resource).user_form.phone
    assert_equal 'email@example.com', assigns(:resource).user_form.email
  end

  test 'После оформления заказа: гость удалится, появится новый пользователь, ему должен назначиться пароль адрес доставки переместится к пользователю, ему улетит письмо о регистрации и совершении заказа, товары из корзины должны переместиться в заказ и сменить статус' do
    ActionMailer::Base.deliveries.clear
    guest = users(:guest)
    post :create, {
      "orders_delivery_form"=>{
        "user_form_attributes"=>{
          "name"=>"1",
          "email"=>"some-email-address@example.com",
          "phone"=>"+7 (111) 111-11-11"},
         "postal_address_id"=>"-1",
         "new_postal_address_attributes"=>{"is_moscow"=>"1", "street"=>"street", "house"=>"1", "stand_alone_house"=>"1"}}}, 
      guest_user_id: guest.id
    order = assigns(:resource).order
    refute User.find_by(id: guest.id)
    user = User.last
    assert user.orders.size == 1
    assert_equal "user", user.role
    assert_equal 'some-email-address@example.com', user.email
    assert_equal 'street', user.postal_addresses.first.street
    assert_equal order.postal_address, user.postal_addresses.first
    assert_empty user.products.incart.where(deliveries_place_id: nil).to_a
    refute_empty order.products.inorder.where(deliveries_place_id: nil).to_a
    assert user.encrypted_password
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['some-email-address@example.com'], ActionMailer::Base.deliveries.last.to
  end

end
