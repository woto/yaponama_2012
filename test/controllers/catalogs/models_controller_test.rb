require 'test_helper'

class Catalogs::ModelsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 32492' do
    get :show, id: models(:galant)
    assert_select '.page-header', 'ЗАПЧАСТИ НА MITSUBISHI Galant (рус. Галант)'
    assert_select '.breadcrumb', /^Каталог.*MITSUBISHI.*Galant$/m
    assert_select '#catalogs-model-generations', 'ЗАПЧАСТИ НА MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    assert_select '#catalogs-model-content', 'Описание Галанта.'
    assert_select '#best-parts-list', '3310 (INFINITI) ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА MITSUBISHI Galant'
  end

end
