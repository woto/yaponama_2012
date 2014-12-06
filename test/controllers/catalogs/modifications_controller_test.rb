require 'test_helper'

class Catalogs::ModificationsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23574523' do
    get :show, id: modifications(:mitsubishi_galant_9_2_cn_sedan)
    assert_select '.page-header', 'MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
    assert_select '.breadcrumb', /^Каталог.*MITSUBISHI.*Galant.*2008 - 2013, 9 поколение \[2-й рестайлинг\].*CN седан 4-дв. 2.0 AT \(160 л. с.\)$/m
    assert_select '#catalogs-modification-content', 'Описание модификации CN седана 4-х дверного.'
    assert_select '#best-parts-list', '2102 (NISSAN) САЙЛЕНТБЛОК НА MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
  end

end
