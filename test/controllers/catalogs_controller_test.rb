require 'test_helper'

class CatalogsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23489' do
    get :show
    assert_select '.page-header', 'Каталоги автозапчастей'
    assert_select '.brands', /Запчасти на BRAND1 \(1 шт.\)\s+Запчасти на BRAND2 \(1 шт.\)\s+Запчасти на KI \(1 шт.\)\s+Запчасти на MITSUBISHI \(9 шт.\)\s+Запчасти на TOYOTA \(8 шт.\)/m
  end

  test 'Проверяем @discourse на :show' do
    get :show
    assert_equal ['Каталоги автозапчастей'], assigns(:discourse)
  end

end

