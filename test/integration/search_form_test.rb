# encoding: utf-8
#
require 'test_helper'

class SearchFormTest < ActionDispatch::IntegrationTest

  test 'Если пользователь находится на главной странице и вбивает в верхнюю панельку поиска каталожник, то он должен быть переадресован на правильный адрес' do
    Capybara.reset!
    visit '/'
    fill_in 'catalog_number', with: '1', match: :first

    assert has_no_link? 'Форма', 'Пользователь не должен видеть кнопку формы'

    click_button 'Найти', match: :first

    path = '/user/products/new?catalog_number=1&product_id=&return_path=%252F&utf8=%25E2%259C%2593'

    assert has_text? 'Вы так же можете попробовать посмотреть'

    uri = URI.parse(current_url)
    assert_equal path, "#{uri.path}?#{uri.query}"
  end

  test 'Если мы находимся на этапе редактирования товара то при щелчке на поиск должно сохраняться состояние редактирования товара - т.е. id редактируемого товара и edit, а не new ну и пометка, что производится редактирование' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    product = products(:otto7)
    visit "/admin/products/#{product.id}/edit?return_path=%2Fadmin%2Fproducts%2Fstatus%2Fall%3F&skip=true"

    assert has_text?("Редактирование позиции 2391920-322312 (KIA)"), 'Должна быть пометка о том, что мы производим редактирование'

    assert has_link? 'Форма', 'Администратор должен видеть кнопку формы редактирования'

    fill_in 'catalog_number', with: '1'
    click_button 'Найти'

    sleep 1

    path = '/admin/users/128399616/products/809317025/edit?catalog_number=1&product_id=&return_path=%252Fadmin%252Fproducts%252Fstatus%252Fall%253F&utf8=%25E2%259C%2593'

    assert has_text?('Вы так же можете попробовать посмотреть')

    uri = URI.parse(current_url)
    assert_equal path, "#{uri.path}?#{uri.query}"

    assert has_field?('catalog_number', :with => "1"), 'Каталожный номер в поиске должен обновиться в соответствии с новым искомым номером'

  end

  test 'Перезаказ' do
    Capybara.reset!
    auth('+7 (555) 555-55-55', '5555555555')
    product = products(:otto6)
    visit "/user/products/#{product.id}/products/new?return_path=%2Fuser%2Fproducts%2Fstatus%2Fall%3Fprimary_key%3D44%26sort_column%3Dcached_brand%26sort_direction%3Dasc&skip=true"
    assert has_text?('Позиция будет отражена как перезаказанная с 129123012-329128 (KIA)'), 'Должен отображаться alert с информацией о том, что производится перезаказ'

    within 'nav' do
      fill_in('catalog_number', with: '2')
      click_button 'Найти'
    end

    assert has_text? 'Вы так же можете попробовать посмотреть'

    uri = URI.parse(current_url)
    assert_equal "/user/products/new?catalog_number=2&product_id=#{product.id}&return_path=%252Fuser%252Fproducts%252Fstatus%252Fall%253Fprimary_key%253D44%2526sort_column%253Dcached_brand%2526sort_direction%253Dasc&utf8=%25E2%259C%2593", "#{uri.path}?#{uri.query}"

  end

end
