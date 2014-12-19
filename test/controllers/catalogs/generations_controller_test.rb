require 'test_helper'

class Catalogs::GenerationsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 3495872' do
    get :show, id: generations(:galant_9_2)
    assert_select '.page-header', 'ЗАПЧАСТИ НА MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    assert_select '.breadcrumb', /^Каталог.*MITSUBISHI.*Galant.*2008 - 2013, 9 поколение \[2-й рестайлинг\]$/m
    assert_select '#catalogs-generation-modifications', 'ЗАПЧАСТИ НА  MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
    assert_select '#catalogs-generation-content', 'Описание 9-ого поколения, 2-ого рестайлинга'
    assert_select '#best-parts-list', /.*3310 \(TOYOTA\).*2102 \(NISSAN\).*/m
  end

end
