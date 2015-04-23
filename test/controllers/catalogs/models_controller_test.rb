require 'test_helper'

class Catalogs::ModelsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 32492' do
    get :show, id: models(:galant)
    assert_select '.page-header', 'Запчасти на MITSUBISHI Galant (рус. Галант)'
    assert_select '.breadcrumb', /^Каталог.*MITSUBISHI.*Galant$/m
    #TODO переработать
    #assert_select '#catalogs-model-generations', 'ЗАПЧАСТИ на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    #assert_select '#catalogs-model-content', 'Описание Галанта.'
    #
    #TODO переработать
    #assert_select '#best-parts-list', /3310 \(INFINITI\) ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant.*3310 \(TOYOTA\) РУЛЕВАЯ ТЯГА на MITSUBISHI Galant.*2102 \(NISSAN\) САЙЛЕНТБЛОК на MITSUBISHI Galant.*/m
  end

end
