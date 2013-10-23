# encoding: utf-8

require 'test_helper'
require 'controllers/attributes/products_attributes'

class Admin::ProductsControllerTest < ActionController::TestCase
  include ProductsAttributes
  
  test 'Тестируем добавление администратором товара пользователю с еще не существующим брендом.' do

    cookies['auth_token'] = somebodies(:first_admin).auth_token
    @user = somebodies(:first_admin)
    return_path = '/user'
    post :create, {:user_id => @user.id, :product => new_brand, :return_path => return_path}

    brand = Brand.last
    assert_equal "new", brand.name, 'Созданный бренд имеет неверное название'
    assert_equal brand.phantom, true, 'Созданный бренд должен быть фантомом'

    product = @user.products.last
    assert_equal product, assigns(:resource), 'Добавленный товар не равен обрабатываемому @resource'
    assert_equal 'new', product.catalog_number, 'Добавленный товар имеет неверный каталожный номер'
    assert_equal 'incart', product.status 'Добавленный товар имеет неверный статус'
    assert_equal brand, product.brand, 'Ассоциация у добавленного товара parent_brand не равна созданной автоматически созданной модели brand'
    assert_equal 'new', product.cached_brand, 'Кешированное значение бренда у добавленного товара неверное'
    
    assert_response :redirect, 'Редирект не произошел'
    assert_redirected_to return_path, 'Редирект произошел не неверный адрес'

  end

end
