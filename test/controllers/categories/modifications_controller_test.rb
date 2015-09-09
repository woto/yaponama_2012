require 'test_helper'

class Categories::ModificationsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23489543' do
    get :show, id: modifications(:mitsubishi_galant_9_2_cn_sedan), category_id: spare_catalogs(:sailentblock)
    assert_select '.page-header', 'САЙЛЕНТБЛОК на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
    assert_select '.breadcrumb', /^Главная\s+Каталоги\s+MITSUBISHI\s+Galant\s+САЙЛЕНТБЛОК\s+2008 - 2013, 9 поколение \[2-й рестайлинг\]\s+CN седан 4-дв. 2.0 AT \(160 л. с.\)$/m
    # TODO тут произошли изменения. Нужно переписать
    #assert_select '#best-parts-list', '2102 (NISSAN) САЙЛЕНТБЛОК на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
  end

  test 'Быстрый тест на содержание страницы. с opt Аккумулятор' do
    get :show, id: modifications(:mitsubishi_galant_9_2_cn_sedan), category_id: spare_catalogs(:akb)
    assert_select '.page-header', 'Батарея аккумуляторная на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
    assert_select '.breadcrumb', /^Главная\s+Запчасти\s+Батарея аккумуляторная\s+MITSUBISHI\s+Galant\s+2008 - 2013, 9 поколение \[2-й рестайлинг\]\s+CN седан 4-дв. 2.0 AT \(160 л. с.\)$/m
    # TODO тут произошли изменения. Нужно переписать
    #assert_select '#best-parts-list', '2102 (NISSAN) САЙЛЕНТБЛОК на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг] CN седан 4-дв. 2.0 AT (160 л. с.)'
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: modifications(:camry_xv50_standard), category_id: spare_catalogs(:akb)
    assert_equal ["Батарея аккумуляторная на TOYOTA Camry Camry (XV50) (2011) 2.0 AT (148 л. с.) стандарт"], assigns(:discourse)
  end

  test 'Проверяем работу titles_as_string' do
    get :show, {id: modifications(:mitsubishi_galant_9_2_cn_sedan), category_id: spare_catalogs(:rulevaya_tyga), "q" => {"titles_as_string_cont"=>"itles_as_strin"}}
    assert_equal SpareInfo.where(id: spare_infos(:titles_as_string)).to_a, assigns(:spare_infos).to_a
  end

end
