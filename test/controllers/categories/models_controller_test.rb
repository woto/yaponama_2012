require 'test_helper'

class Categories::ModelsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 348934' do
    get :show, id: models(:galant), category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant (рус. Галант)'
    assert_select '.breadcrumb', /^Каталоги\s+MITSUBISHI\s+Galant$\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ/m
    #TODO переработать
    #assert_select '#best-parts-list', '3310 (INFINITI) ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant'
  end

  test 'Быстрый тест на содержание страницы 89745323' do
    get :show, id: models(:galant), category_id: spare_catalogs(:akb)
    assert_select '.page-header', 'Батарея аккумуляторная на MITSUBISHI Galant (рус. Галант)'
    assert_select '.breadcrumb', /^Запчасти\s+Батарея аккумуляторная\s+MITSUBISHI\s+Galant$/m
    #TODO переработать
    #assert_select '#best-parts-list', '3310 (INFINITI) ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant'
  end
end
