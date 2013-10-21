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
    assert_equal brand.name, "NEW", 'Созданный бренд имеет неверное название'
    assert_equal brand.phantom, true, 'Созданный бренд должен быть фантомом'

    product = @user.products.last
    assert_equal assigns(:resource), product, 'Добавленный товар не равен обрабатываемому @resource'
    assert_equal product.catalog_number, 'new', 'Добавленный товар имеет неверный каталожный номер'
    assert_equal product.status, 'incart', 'Добавленный товар имеет неверный статус'
    assert_equal product.parent_brand, brand, 'Ассоциация у добавленного товара parent_brand не равна созданной автоматически созданной модели brand'
    assert_equal product.cached_parent_brand, 'NEW', 'Кешированное значение бренда у добавленного товара неверное'
    
    assert_response :redirect, 'Редирект не произошел'
    assert_redirected_to return_path, 'Редирект произошел не неверный адрес'

  end

end
