require 'test_helper'

class Categories::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 2398' do
    get :show, id: brands(:mitsubishi), category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /^Главная\s+Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+MITSUBISHI$/m
    assert_select '#categories-brands-show-models', /^ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant \(1 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Lancer \(1 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Lancer Ralliart \(1 шт.\)$/m
  end

end
