require 'test_helper'

class Categories::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 2398' do
    get :show, id: brands(:mitsubishi), category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /^Главная\s+Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+MITSUBISHI$/m
    assert_select '#categories-brands-show-models', /^ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant \(1 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Lancer \(1 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Lancer Ralliart \(1 шт.\)$/m
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: brands(:toyota), category_id: spare_catalogs(:akb)
    assert_equal ['Батарея аккумуляторная на TOYOTA'], assigns(:discourse)
  end

  test 'Проверяем работу titles_as_string' do
    get :show, {id: brands(:mitsubishi), category_id: spare_catalogs(:rulevaya_tyga), "q" => {"titles_as_string_cont"=>"itles_as_strin"}}
    assert_equal SpareInfo.where(id: spare_infos(:titles_as_string)).to_a, assigns(:spare_infos).to_a
  end

end
