require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23498234' do
    get :index
    assert_select '.page-header', 'Запчасти'
    assert_select '#categories-brands', /БАМПЕР ЗАДНИЙ\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+РУЛЕВАЯ ТЯГА\s+САЙЛЕНТБЛОК\s+ШАТУН/m
  end

  test 'Быстрый тест на содержание страницы 348934' do
    get :show, id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ'
    assert_select '.breadcrumb', /^Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ$/m
    assert_select '#category-brands', /^ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА MITSUBISHI\s+ ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ НА TOYOTA$/m
    #assert_select '#category-intro', 'Короткое описание что такое пыльник рулевой тяги.'
    assert_select '#category-page', 'Подробное описание что такое пыльник рулевой тяги.'
  end

end
