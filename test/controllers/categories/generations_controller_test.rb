require 'test_helper'

class Categories::GenerationsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 283948' do
    get :show, id: generations(:galant_9_2), category_id: spare_catalogs(:rulevaya_tyga)
    assert_select '.page-header', 'РУЛЕВАЯ ТЯГА на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    assert_select '.breadcrumb', /^Главная\s+Каталоги\s+MITSUBISHI\s+Galant\s+РУЛЕВАЯ ТЯГА\s+2008 - 2013, 9 поколение \[2-й рестайлинг\]$/m
    #TODO переработать
    #assert_select '#best-parts-list', '3310 (TOYOTA) РУЛЕВАЯ ТЯГА на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
  end

  test 'Быстрый тест на содержание страницы 234598' do
    get :show, id: generations(:galant_9_2), category_id: spare_catalogs(:akb)
    assert_select '.page-header', 'Батарея аккумуляторная на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    assert_select '.breadcrumb', /^Главная\s+Запчасти\s+Батарея аккумуляторная\s+MITSUBISHI\s+Galant\s+2008 - 2013, 9 поколение \[2-й рестайлинг\]$/m
    #TODO Переработать
    #assert_select '#best-parts-list', '3310 (TOYOTA) РУЛЕВАЯ ТЯГА на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: generations(:camry_xv50), category_id: spare_catalogs(:akb)
    assert_equal ['Батарея аккумуляторная на TOYOTA Camry Camry (XV50) (2011)'], assigns(:discourse)
  end

end
