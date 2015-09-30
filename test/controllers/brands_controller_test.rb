require 'test_helper'

class BrandsControllerTest < ActionController::TestCase

  # Проверяем работу поиска по подстроке
  #
  test 'Запрашивая TOYOT мы должны увидеть TOYOTA' do
    get :search, q: {name_cont: 'TOYOT'}, manufacturer: '0', format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end

  test 'Запрашивая BAND мы должны увидеть BANDO.' do
    get :search, q: {name_cont: 'BAND'}, manufacturer: '0', format: :json
    body = JSON.parse(response.body)
    assert_equal 'BANDO', body.first['name']
  end





  # Проверяем работу manufacturer
  #

  test 'Если мы передаем флаг manufacturer: 1 и BANDO, то мы не находим BANDO, т.к. он не is_brand' do
    get :search, q: {name_cont: 'BANDO'}, manufacturer: '1', format: :json
    body = JSON.parse(response.body)
    assert_empty body
  end

  test 'Если мы передаем флаг manufacturer: 0 и BANDO, то находим, т.к. у него нет родителя' do
    get :search, q: {name_cont: 'BANDO'}, manufacturer: '0', format: :json
    body = JSON.parse(response.body)
    assert_equal 'BANDO', body.first['name']
  end

  test 'Если мы передаем флаг manufacturer: 1 и TOYOTA, то мы находим TOYOTA, т.к. у него выставлен is_brand' do
    get :search, q: {name_cont: 'TOYOTA'}, manufacturer: '1', format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end 

  test 'Если мы передаем флаг manufacturer: 0 и TOYOTA, то мы все равно находим TOYOTA, т.к. у него не выставлен родительский бренд' do
    get :search, q: {name_cont: 'TOYOTA'}, manufacturer: '0', format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end

  test 'Если мы передаем флаг manufacturer: 1, то находим Child 1, т.к. у него выставлен is_brand, несмотря на наличие родительского бренда' do
    get :search, q: {name_cont: 'Child 1'}, manufacturer: '1', format: :json
    body = JSON.parse(response.body)
    assert_equal 'Child 1 conglomerate', body.first['name']
  end

  test 'Если мы передаем флаг manufacturer: 0, то мы не находим Child 2, т.к. у него выставлен родительский бренд, зато находим Child 1 & Child 2' do
    get :search, q: {name_cont: 'Child 2'}, manufacturer: '0', format: :json
    body = JSON.parse(response.body)
    assert_equal 1, body.size
    assert_equal 'Child 1 & Child 2', body.first['name']
  end






  test 'Проверяем @discourse на :index' do
    get :index
    assert_equal ['Бренды'], assigns(:discourse)
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: brands(:toyota)
    assert_equal ["Производитель запчастей TOYOTA"], assigns(:discourse)
  end

end
