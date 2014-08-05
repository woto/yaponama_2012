require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23498234' do
    get :index
    assert_select '.page-header', 'Категории запчастей'
    assert_select '#categories-brands', /БАМПЕР ЗАДНИЙ\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+РУЛЕВАЯ ТЯГА\s+САЙЛЕНТБЛОК/ 
  end

end
