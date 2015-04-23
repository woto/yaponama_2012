# encoding: utf-8
#
require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase

  test 'Продавец должен видеть кнопку Форма' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get :new, product_id: products(:sending1), user_id: somebodies(:sending1)
    assert_select "a[href='#modal_form']"
  end
  
  test 'Тестируем добавление администратором товара пользователю с еще не существующим брендом.' do

    cookies['auth_token'] = somebodies(:first_admin).auth_token
    @user = somebodies(:first_admin)
    return_path = 'http://ya.ru'
    post :create, {:user_id => @user.id, :product => {
     "catalog_number"=>"new",
     "hide_catalog_number"=>"0",
     "brand_attributes" => { "name" => "New" },
     "short_name"=>"new",
     "quantity_ordered"=>"1",
     "buy_cost"=>"1",
     "sell_cost"=>"1",
     "long_name"=>"new",
     "quantity_available"=>"1",
     "probability"=>"1",
     "min_days"=>"1",
     "max_days"=>"1",
     "notes"=>"new",
     "notes_invisible"=>"new"
    }, :return_path => return_path, :commit => 'x'}

    brand = Brand.last
    assert_equal "New", brand.name, 'Созданный бренд имеет неверное название'
    assert_equal brand.phantom, true, 'Созданный бренд должен быть фантомом'

    product = @user.products.last
    assert_equal product, assigns(:resource), 'Добавленный товар не равен обрабатываемому @resource'
    assert_equal 'new', product.catalog_number, 'Добавленный товар имеет неверный каталожный номер'
    assert_equal 'incart', product.status, 'Добавленный товар имеет неверный статус'
    assert_equal brand, product.brand, 'Ассоциация у добавленного товара parent_brand не равна созданной автоматически созданной модели brand'
    assert_equal 'New', product.cached_brand, 'Кешированное значение бренда у добавленного товара неверное'
    
    assert_response :redirect, 'Редирект не произошел'
    #assert_redirected_to admin_user_product_path(@user, product, :return_path => 'http://ya.ru'), 'Редирект произошел не неверный адрес'
    assert_redirected_to status_admin_user_products_path(@user, 'incart'), 'Редирект должен был произойти в корзину пользователя'

  end

  test 'Изменение закупочной и продажной цен товара в статусе post_supplier' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token

    patch :update, {
      "product" => {
        "product_id"=>"",
        "catalog_number"=>"MR245368",
        "hide_catalog_number"=>"1",
        "brand_attributes"=>{"name"=>"MITSUBISHI", "id"=>"856124188"},
        "short_name"=>"НАСОС ОМЫВАТЕЛЯ",
        "quantity_ordered"=>"4",
        "buy_cost"=>"351.00",
        "sell_cost"=>"392.00",
        "long_name"=>"НАСОС ОМЫВАТЕЛЯ СТЕКЛА, ЛОБОВОГО",
        "quantity_available"=>"2",
        "probability"=>"95",
        "min_days"=>"5",
        "max_days"=>"9",
        "notes"=>"",
        "notes_invisible"=>""},
     "return_path" => '/user',
     "user_id" => somebodies(:anton).id,
     "id" => products(:anton_fifth).id,
     "commit" => 'x'
   }

    pt = products(:anton_fifth).product_transactions.first
    at1 = AccountTransaction.first
    at2 = AccountTransaction.last

    assert_equal 'update', pt.operation
    assert_equal 352, pt.buy_cost_before
    assert_equal 351, pt.buy_cost_after
    assert_equal 390, pt.sell_cost_before
    assert_equal 392, pt.sell_cost_after
    assert_equal 2, AccountTransaction.count
    assert_equal pt.id, at1.product_transaction_id
    assert_equal pt.id, at2.product_transaction_id
    assert_equal 0, at1.credit_before
    assert_equal 0, at2.credit_before
    assert_equal 8, at1.credit_after
    assert_equal -4, at2.credit_after.to_f

    assert_equal "Товар MR245368 (MITSUBISHI) успешно изменен.", flash['attention']
    assert_redirected_to "/admin/users/#{somebodies(:anton).id}/products/status/incart"

  end

end
