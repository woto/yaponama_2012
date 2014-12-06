require 'test_helper'

class Categories::ModificationsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23489543' do
    get :show, id: modifications(:mitsubishi_galant_9_2_cn_sedan), category_id: spare_catalogs(:sailentblock)
    assert_select '.page-header', 'САЙЛЕНТБЛОК MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
    assert_select '.breadcrumb', /^Запчасти\s+САЙЛЕНТБЛОК\s+MITSUBISHI\s+Galant\s+2008 - 2013, 9 поколение \[2-й рестайлинг\]\s+CN седан 4-дв. 2.0 AT \(160 л. с.\)$/m
    assert_select '#best-parts-list', '2102 (NISSAN) САЙЛЕНТБЛОК НА MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
  end

end


