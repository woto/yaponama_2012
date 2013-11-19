# encoding: utf-8
#
require 'test_helper'

class SearchFormTest < ActionDispatch::IntegrationTest
  test 'Если пользователь находится на главной странице и вбивает в верхнюю панельку поиска каталожник, то он должен быть переадресован на правильный адрес' do
    Capybara.reset!
    visit '/'
    fill_in 'catalog_number', with: '1'
    click_button 'Искать'

    path = '/user/products/new?utf8=%25E2%259C%2593&catalog_number=1&product_id=&return_path=%252F'

    uri = URI.parse(current_url)
    assert_equal path, "#{uri.path}?#{uri.query}"
  end

  test 'Если мы находимся на этапе редактирования товара то при щелчке на поиск должно сохраняться состояние редактирования товара - т.е. id редактируемого товара и edit, а не new ну и пометка, что производится редактирование' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    product = products(:otto7)
    visit "/admin/products/#{product.id}/edit?return_path=%2Fadmin%2Fproducts%2Fstatus%2Fall%3F&skip=true"

    assert has_field?('catalog_number', :with => "#{product.catalog_number}")

    fill_in 'catalog_number', with: '1'
    click_button 'Искать'

    path = '/admin/users/128399616/products/809317025/edit?utf8=%25E2%259C%2593&catalog_number=1&product_id=&return_path=%252Fadmin%252Fproducts%252Fstatus%252Fall%253F'

    assert has_text? 'Редактирование позиции 2391920-322312 (KIA)'
    uri = URI.parse(current_url)
    assert_equal path, "#{uri.path}?#{uri.query}"

    assert has_field?('catalog_number', :with => "1")

  end

  test 'Перезаказ' do
    skip
  end

end
