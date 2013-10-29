# encoding: utf-8

require 'test_helper'

class Admin::ProductsTest < ActionDispatch::IntegrationTest

  test 'Если у товара стоит сокрытие каталожного номера, то он показывается администратору со звездочкой' do
    id = products(:anton_first).id
    anton = somebodies(:anton)
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get_via_redirect "/admin/users/#{anton.id}/products"
    assert_select "#catalog_number_product_#{id}" do |elements|
      elements.each do |el|
        assert_match /2102/, el.to_s
        assert_select "i[class=?]", /.*asterisk.*/
      end
    end
  end

  test 'Если мы накладываем фильтр, то она отображается независимо от того, что каталожный номер сокрыт' do
    id = products(:anton_first).id
    anton = somebodies(:anton)
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get_via_redirect "/admin/users/#{anton.id}/products"
    post_via_redirect "/admin/users/#{anton.id}/products/filters/", "primary_key" => request.params['primary_key'], "filters" => 'ok', "grid[filter_catalog_number_like]" => '2102'
    assert_select "#product_#{id}", true
  end

  test 'Если мы щелкаем на товаре, который заказали в кол-ве более 1 шт., то есть ссылка для разбития на партии' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get_via_redirect "/admin/users/#{somebodies(:anton).id}/products/#{products(:anton_first).id}/info"
    assert_select 'li', :text => 'Разбить на партии'
  end

  test 'Если мы щелкаем на товаре, который заказали в кол-ве 1 шт., то ссылки на разбитие на партии нет' do
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get_via_redirect "/admin/users/#{somebodies(:anton).id}/products/#{products(:anton_third).id}/info"
    assert_select 'li', :text => 'Разбить на партии', :count => 0
  end


end
