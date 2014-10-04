require 'test_helper'

class BrandsControllerTest < ActionController::TestCase

  # Проверяем работу поиска по подстроке
  #
  test 'Запрашивая TOYOT мы должны увидеть TOYOTA' do
    get :search, name: 'TOYOT', format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end

  test 'Запрашивая BAND мы должны увидеть BANDO.' do
    get :search, name: 'BAND', format: :json
    body = JSON.parse(response.body)
    assert_equal 'BANDO', body.first['name']
  end

  # Проверяем работу поиска по синониму
  #
  test 'Запрашивая TY мы должны увидеть TOYOTA. Но не должны увидеть TY' do
    get :search, name: 'ty', format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end

  test 'Запрашивая БАНДО мы должны увидеть BANDO. Но не должны увидеть БАНДО' do
    get :search, name: 'БАНДО', format: :json
    body = JSON.parse(response.body)
    assert_equal 'BANDO', body.first['name']
  end


  # Проверяем работу is_brand
  #
  test 'Если мы передаем флаг is_brand и TOYOTA, то мы находим TOYOTA' do
    get :search, name: 'TOYOTA', is_brand: true, format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end

  test 'Если мы передаем флаг is_brand и TY, то мы находим TOYOTA' do
    get :search, name: 'TOYOTA', is_brand: true, format: :json
    body = JSON.parse(response.body)
    assert_equal 'TOYOTA', body.first['name']
  end

  test 'Если мы передаем флаг is_brand и BANDO, то мы не находим BANDO' do
    get :search, name: 'BANDO', is_brand: true, format: :json
    body = JSON.parse(response.body)
    assert_empty body
  end

  test 'Если мы передаем флаг is_brand и БАНДО, то мы не находим BANDO' do
    get :search, name: 'БАНДО', is_brand: true, format: :json
    body = JSON.parse(response.body)
    assert_empty body
  end

end
