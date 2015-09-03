require 'test_helper'

class Catalogs::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 235245' do
    get :show, id: brands(:mitsubishi)
    assert_select '.page-header', 'Запчасти на MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /^Главная\s+Каталоги\s+MITSUBISHI$/m
    assert_select '#catalogs-brands-show-models', /^Запчасти на MITSUBISHI Galant \(4 шт.\)\s+Запчасти на MITSUBISHI Lancer \(3 шт.\)\s+Запчасти на MITSUBISHI Lancer Ralliart \(2 шт.\)$/m
    #TODO Переработать
    #assert_select '#best-parts-list', /.*2103 \(KI\).*2102 \(KI\).*3310 \(INFINITI\).*3310 \(TOYOTA\).*2102 \(NISSAN\).*/m
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: brands(:toyota)
    assert_equal ['Запчасти на TOYOTA'], assigns(:discourse)
  end

end
