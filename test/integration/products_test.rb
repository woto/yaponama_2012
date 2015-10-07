require 'test_helper'

class ProductsTest < ActionDispatch::IntegrationTest

  test 'После поиска артикула у нас должна заполниться история' do
    get new_user_product_path(catalog_number: '2103')
    assert_equal [['2103', '2103 MITSUBISHI, KI Задний бампер']], session[:history]
  end

  test 'Если у товара стоит сокрытие каталожного номера, то показывается только звездочка' do
    id = products(:anton_first).id
    sign_in(users(anton))
    get_via_redirect '/user/products'
    #assert_select "#catalog_number_product_#{id}", :text => '2102', count: 0
    assert_select "#catalog_number_product_#{id}" do |elements|
      elements.each do |el|
        refute_match /2102/, el.to_s
        assert_select "i:match('class', ?)", /.*asterisk.*/
      end
    end
  end

  test 'Если у товара не стоит сокрытие каталожного номера, то мы прекрасного его видим' do
    id = products(:anton_second).id
    sign_in(users(:anton))
    get_via_redirect '/user/products'
    assert_select "#catalog_number_product_#{id}", :text => '3310'
  end

  test 'Если мы накладываем фильтр по кат. номеру, то даже при условии что он совпадает мы не увидим этой детали' do
    id = products(:anton_first).id
    sign_in(users(:anton))
    get_via_redirect '/user/products'
    xhr :post, '/user/products/filter', "primary_key" => request.params['primary_key'], "filters" => 'ok', "grid[filter_catalog_number_like]" => '2102', format: :js 
    follow_redirect!
    refute_match /product_#{id}/, response.body
  end

  test 'Просматриваем страницу заказа' do
    get_via_redirect '/user/orders/404-14-104/products/'
    assert_select 'title', 'Просмотр заказа № 404-14-104'
  end
  test 'Если такой элемент уже имеется в истории, то он не должен добавиться повторно' do
    get new_user_product_path(catalog_number: '2103')
    assert_equal [['2103', '2103 MITSUBISHI, KI Задний бампер']], session[:history]

  test 'Просматриваем страницу изменения способа доставки' do
    get_via_redirect '/user/orders/404-14-104/delivery/edit'
    assert_select 'title', 'Выбор способа доставки'
  end
    get new_user_product_path(catalog_number: '3310')
    assert_equal [["2103", "2103 MITSUBISHI, KI Задний бампер"], ["3310", "3310 TOYOTA, INFINITI Пыльник рул. рейки"]], session[:history]

  test '(Как бы) Кликаем на info кнопке заказа' do
    get_via_redirect '/user/orders/404-14-104/info'
    assert_template 'application/info'
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
    assert_text 'Товар добавлен в корзину'
    sleep 10
  end

  test 'После успешного добавления товара в корзину должны появиться слова о том, что товар помещен в корзину' do
    visit new_user_product_path(catalog_number: '2102')
    find('#iCheck-offer_deliveries_place').click
    click_button 'submit-2102-nissan'
    assert_text 'Товар добавлен в корзину'
  end

  test 'В случае если не выбрали способ получения товара, то должна появиться подсказка' do
    visit new_user_product_path(catalog_number: '2102')
    click_button 'submit-2102-nissan'
    assert_text 'Пожалуйста выберите способ получения товара'
  end

end
