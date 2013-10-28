# encoding: utf-8

require 'test_helper'

class Admin::ProductsTest < ActionDispatch::IntegrationTest

  test 'Если у товара стоит сокрытие каталожного номера, то он показывается администратору со звездочкой' do
    id = products(:first_admin_first_product).id
    cookies['auth_token'] = somebodies(:first_admin).auth_token
    get_via_redirect '/admin/products'
    assert_select "#catalog_number_product_#{id}", :text => '2102', count: 1
  end

end

