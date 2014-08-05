require 'test_helper'

class Catalogs::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы' do
    get :show, id: brands(:mitsubishi)
    assert_select '.page-header', 'MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /Каталог.*MITSUBISHI/m
    assert_select '#catalogs-brands', /Galant\s+Lancer\s+Lancer Ralliart/m
    assert_select '#catalogs-brand-preview', 'Вступление'
    assert_select '#catalogs-brand-content', 'Описание'
  end

end
