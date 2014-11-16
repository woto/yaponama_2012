require 'test_helper'

class Categories::GenerationsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 283948' do
    get :show, id: generations(:galant_9_2), category_id: spare_catalogs(:rulevaya_tyga)
    assert_select '.page-header', 'РУЛЕВАЯ ТЯГА MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    assert_select '.breadcrumb', /^Запчасти\s+РУЛЕВАЯ ТЯГА\s+MITSUBISHI\s+Galant\s+2008 - 2013, 9 поколение \[2-й рестайлинг\]$/m
    assert_select '#best-parts-list', '3310 (TOYOTA) РУЛЕВАЯ ТЯГА'
  end

end
