# encoding: utf-8

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
        assert_select "i[class=?]", /.*asterisk.*/
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
    post_via_redirect '/user/products/filters/', "primary_key" => request.params['primary_key'], "filters" => 'ok', "grid[filter_catalog_number_like]" => '2102'
    assert_select "#product_#{id}", false

  end

  test 'Если мы щелкаем на товаре, который заказали в кол-ве более 1 шт., то есть ссылка для разбития на партии' do
    cookies['auth_token'] = somebodies(:anton).auth_token
    id = products(:anton_first).id
    get_via_redirect "/user/products/#{id}/info"
    assert_select 'li', :text => 'Разбить на партии'
  end

  test 'Если мы щелкаем на товаре, который заказали в кол-ве 1 шт., то ссылки на разбитие на партии нет' do
    cookies['auth_token'] = somebodies(:anton).auth_token
    id = products(:anton_third).id
    get_via_redirect "/user/products/#{id}/info"
    assert_select 'li', :text => 'Разбить на партии', :count => 0
  end

  test 'Проверяем правильность ссылки data-poload для popover ID столбца' do
    cookies['auth_token'] = somebodies(:anton).auth_token
    get_via_redirect '/user/products'

    primary_key = request['primary_key']
    third = products(:anton_third).id

    assert_select "#id_product_#{third}" do
      assert_select 'a[data-poload=?]', Regexp.new(Regexp.quote("/user/products/#{third}/info?primary_key=#{primary_key}&amp\;return_path=%2Fuser%2Fproducts%2Ffilter%3Fprimary_key%3D#{primary_key}"))
    end
  end

end
