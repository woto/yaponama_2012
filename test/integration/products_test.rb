require 'test_helper'

class ProductsTest < ActionDispatch::IntegrationTest

  test 'Если у товара стоит сокрытие каталожного номера, то показывается только звездочка' do
    id = products(:anton_first).id
    cookies['auth_token'] = somebodies(:anton).auth_token
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
    cookies['auth_token'] = somebodies(:anton).auth_token
    get_via_redirect '/user/products'
    assert_select "#catalog_number_product_#{id}", :text => '3310'
  end

  test 'Если мы накладываем фильтр по кат. номеру, то даже при условии что он совпадает мы не увидим этой детали' do
    id = products(:anton_first).id
    cookies['auth_token'] = somebodies(:anton).auth_token
    get_via_redirect '/user/products'
    xhr :post, '/user/products/filter', "primary_key" => request.params['primary_key'], "filters" => 'ok', "grid[filter_catalog_number_like]" => '2102', format: :js 
    follow_redirect!
    refute_match /product_#{id}/, response.body
  end

  test 'Проверяем правильность ссылки data-poload для popover ID столбца' do
    cookies['auth_token'] = somebodies(:anton).auth_token
    get_via_redirect '/user/products'

    primary_key = request['primary_key']
    third = products(:anton_third).id

    assert_select "#id_product_#{third}" do |element|
      assert_select "a:match('data-poload', ?)", Regexp.new(Regexp.quote("/user/products/#{third}/info?primary_key=#{primary_key}&return_path=%2Fuser%2Fproducts%2Ffilter%3Fprimary_key%3D#{primary_key}"))
    end
  end

  test 'Просматриваем страницу заказа' do
    get_via_redirect '/user/orders/404-14-104/products/'
    assert_select 'title', 'Просмотр заказа № 404-14-104'
  end

  test 'Просматриваем страницу изменения способа доставки' do
    get_via_redirect '/user/orders/404-14-104/delivery/edit'
    assert_select 'title', 'Выбор способа доставки'
  end

  test '(Как бы) Кликаем на info кнопке заказа' do
    get_via_redirect '/user/orders/404-14-104/info'
    assert_template 'application/info'
  end

  test 'Проверяем meta_canonical' do
    get '/user/products/new?catalog_number=2102&return_path=%2FMITSUBISHI'
    assert_select "link[rel=canonical][href='/user/products/new?catalog_number=2102']"

    get '/user/products/new?catalog_number=2102&replacements=1&return_path=%2Fru%2Fcontacts%2Fmoscow'
    assert_select "link[rel=canonical][href='/user/products/new?catalog_number=2102&replacements=1']"
  end

end
