# encoding: utf-8
#
require 'test_helper'

class BuyButtonTest < ActionDispatch::IntegrationTest

  test 'Проверяем правильность заполнения полей при нажатии на кнопке Купить от buyer' do
    Capybara.reset!
    visit '/user/products/new/?catalog_number=1111111111'

    common()

  end

  test 'Проверяем кнопку Купить от лица seller' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    otto = somebodies(:otto)
    visit "/admin/users/#{otto.id}/products/new?catalog_number=1111111111"

    common()

  end

  def common

    first("a[data-catalog-number='1111111111'][data-manufacturer='ПРОИЗВОДИТ']").click
    fill_in 'product_quantity_ordered', with: 'invalid'
    click_button 'Добавить в корзину'

    assert has_text?('не является числом'), 'Должно повторно отобразиться модальное окно с ошибкой'

    fill_in 'product_quantity_ordered', with: '2'
    click_button 'Добавить в корзину'

    product = Product.last

    assert_equal '1111111111', product.catalog_number
    assert_equal 26, product.sell_cost.to_f
    assert_equal 10, product.quantity_available
    assert_equal 1, product.min_days
    assert_equal 1, product.max_days
    assert_equal 55, product.probability
    assert_equal 'ПРОИЗВОДИТ', product.cached_brand
    assert_equal 23, product.buy_cost.to_f
    assert_equal 'НАЗВАНИЕ 1', product.short_name
    assert_equal 'НАЗВАНИЕ 1, НАЗВАНИЕ 2', product.long_name
    assert_equal 2, product.quantity_ordered

  end

end