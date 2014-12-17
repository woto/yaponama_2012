require 'test_helper'

class Catalogs::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 235245' do
    get :show, id: brands(:mitsubishi)
    assert_select '.page-header', 'ЗАПЧАСТИ НА MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /^Каталог.*MITSUBISHI$/m
    assert_select '#catalogs-brand-models', /^ЗАПЧАСТИ НА MITSUBISHI Galant\s+ЗАПЧАСТИ НА MITSUBISHI Lancer\s+ЗАПЧАСТИ НА MITSUBISHI Lancer Ralliart$/m
    assert_select '#catalogs-brand-preview', 'Вступление'
    assert_select '#catalogs-brand-content', 'Описание'
    assert_select '#best-parts-list', /.*2102 \(KI\).*2103 \(KI\).*3310 \(INFINITI\).*3310 \(TOYOTA\).*2102 \(NISSAN\).*/m
  end

end
