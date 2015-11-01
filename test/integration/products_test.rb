require 'test_helper'

class ProductsTest < ActionDispatch::IntegrationTest

  def setup
    Rails.configuration.common['display_counters'] = true
  end

  def teardown
    Rails.configuration.common['display_counters'] = false
  end

  test 'После поиска артикула у нас должна заполниться история' do
    get new_user_product_path(catalog_number: '2103')
    assert_equal [['2103', '2103 MITSUBISHI, KI Задний бампер']], session[:history]
  end

  test 'Если такой элемент уже имеется в истории, то он не должен добавиться повторно' do
    get new_user_product_path(catalog_number: '2103')
    assert_equal [['2103', '2103 MITSUBISHI, KI Задний бампер']], session[:history]

    get new_user_product_path(catalog_number: '3310')
    assert_equal [["2103", "2103 MITSUBISHI, KI Задний бампер"], ["3310", "3310 TOYOTA, INFINITI Пыльник рул. рейки"]], session[:history]

    get new_user_product_path(catalog_number: '2103')
    assert_equal [["2103", "2103 MITSUBISHI, KI Задний бампер"], ["3310", "3310 TOYOTA, INFINITI Пыльник рул. рейки"]], session[:history]
  end

  test 'Проверяем meta_canonical' do
    get '/user/products/new?catalog_number=2102&return_path=%2F'
    assert_select "link[rel=canonical][href='http://www.example.com/user/products/new?catalog_number=2102']"

    get '/user/products/new?catalog_number=2102&replacements=1&return_path=%2F'
    assert_select "link[rel=canonical][href='http://www.example.com/user/products/new?catalog_number=2102&replacements=1']"
  end

  test 'Если мы посылаем запрос с If-Modified-Since с датой позже полученной ранее Last-Modified, то должен отдаться 304' do
    get new_user_product_path(catalog_number: '2103')
    assert_response 200

    get new_user_product_path(catalog_number: '2103'), {}, {'If-Modified-Since' => (Time.parse(@response.headers['Last-Modified']) + 1.second).httpdate.to_s}
    assert_response 304
  end

  test 'Если мы посылаем запрос с не акутальной If-Modified-Since, то должен отдаться 200' do
    get new_user_product_path(catalog_number: '2103'), {}, {'If-Modified-Since' => (Time.new - 1.year).httpdate.to_s}
    assert_response 200
  end


  test 'Если мы посылаем запрос с :etag который нам уже известен, то должен отдаться 304' do
    get new_user_product_path(catalog_number: '2103')

    get new_user_product_path(catalog_number: '2103'), {}, {'If-None-Match' => @response.headers['ETag']}
    assert_response 304
  end

  test 'Если мы посылаем запрос с не актуальным :etag, то должен отдаться 200' do
    get new_user_product_path(catalog_number: '2103'), {}, {'If-None-Match' => '123'}
    assert_response 200
  end

  test 'iCheck должен добавлять id с написанным iCheck вначале к элементу управления' do
    visit new_user_product_path(catalog_number: '2102')
    find('#iCheck-offer_deliveries_place_309456473').click
    click_button 'submit-2102-nissan'
    assert has_text? 'Товар добавлен в корзину'
  end

  test 'После успешного добавления товара в корзину должны появиться слова о том, что товар помещен в корзину' do
    visit new_user_product_path(catalog_number: '2102')
    find('#iCheck-offer_deliveries_place').click
    click_button 'submit-2102-nissan'
    assert has_text? 'Товар добавлен в корзину'
  end

  test 'В случае если не выбрали способ получения товара, то должна появиться подсказка' do
    visit new_user_product_path(catalog_number: '2102')
    click_button 'submit-2102-nissan'
    assert has_text? 'Пожалуйста выберите способ получения товара'
  end

end
