# encoding: utf-8
#
require 'test_helper'

# TODO пока это тут, до момента пока окончательно не
# разберусь с helper'ами и их тестированием

class PageTitleTest < ActionDispatch::IntegrationTest
  test 'Если заполнены @meta_title и @meta_title_small, то они должны правильно отображаться в заголовке страницы и title window' do
    get_via_redirect "/user/products/status/incart/"
    assert_select 'h1', /Товары/
    assert_select 'h1 > small', 'В корзине'
    assert_select '.page-header > div', 'Вы просматриваете товары, находящиеся в корзине. Отметтье необходимые товары и оформите заказ.'
    assert_select 'title', 'Товары В корзине'
  end
end
