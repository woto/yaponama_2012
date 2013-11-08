# encoding: utf-8

require 'test_helper'
require 'controllers/attributes/products_attributes'

class Admin::ProductsControllerTest < ActionController::TestCase
  include ProductsAttributes
  
  test 'Тестируем добавление администратором товара пользователю с еще не существующим брендом.' do

    cookies['auth_token'] = somebodies(:first_admin).auth_token
    @user = somebodies(:first_admin)
    return_path = 'http://ya.ru'
    post :create, {:user_id => @user.id, :product => new_brand, :return_path => return_path, :commit => 'x'}

    brand = Brand.last
    assert_equal "new", brand.name, 'Созданный бренд имеет неверное название'
    assert_equal brand.phantom, true, 'Созданный бренд должен быть фантомом'

    product = @user.products.last
    assert_equal product, assigns(:resource), 'Добавленный товар не равен обрабатываемому @resource'
    assert_equal 'new', product.catalog_number, 'Добавленный товар имеет неверный каталожный номер'
    assert_equal 'incart', product.status, 'Добавленный товар имеет неверный статус'
    assert_equal brand, product.brand, 'Ассоциация у добавленного товара parent_brand не равна созданной автоматически созданной модели brand'
    assert_equal 'new', product.cached_brand, 'Кешированное значение бренда у добавленного товара неверное'
    
    assert_response :redirect, 'Редирект не произошел'
    assert_redirected_to admin_user_product_path(@user, product, :return_path => 'http://ya.ru'), 'Редирект произошел не неверный адрес'

  end

  test 'Изменение закупочной и продажной цен товара в статусе post_supplier' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token

    patch :update, post_supplier_account_transaction_check(somebodies(:anton).id, products(:anton_fifth).id)

    pt = ProductTransaction.first
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

  end

end
