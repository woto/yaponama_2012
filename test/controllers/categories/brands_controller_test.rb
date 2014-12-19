require 'test_helper'

class Categories::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 2398' do
    get :show, id: brands(:mitsubishi), category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /^Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+MITSUBISHI$/m
    assert_select '#category-models', /^ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА MITSUBISHI Galant\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА MITSUBISHI Lancer\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА MITSUBISHI Lancer Ralliart$/m
  end

end
