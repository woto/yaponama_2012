require 'test_helper'

class Categories::ModelsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 348934' do
    get :show, id: models(:galant), category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ MITSUBISHI Galant (рус. Галант)'
    assert_select '.breadcrumb', /^Категории\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+MITSUBISHI\s+Galant$/m
    assert_select '#best-parts-list', '3310 (INFINITI) ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ'
  end

end
