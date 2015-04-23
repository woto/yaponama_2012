require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23498234' do
    get :index
    assert_select '.page-header', 'Запчасти'
    assert_select '#categories', /БАМПЕР ЗАДНИЙ \(6 шт.\)\s+Батарея аккумуляторная \(1 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ \(4 шт.\)\s+РУЛЕВАЯ ТЯГА \(5 шт.\)\s+САЙЛЕНТБЛОК \(2 шт.\)\s+ШАТУН \(2 шт.\)/m
  end

  test 'Быстрый тест на содержание страницы 348934' do
    get :show, id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ<p>Короткое описание что такое пыльник рулевой тяги.</p>'
    assert_select '.breadcrumb', /^Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ$/m
    assert_select '#category-brands', /^ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI \(3 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на TOYOTA \(1 шт.\)$/m
    #assert_select '#category-intro', 'Короткое описание что такое пыльник рулевой тяги.'
    assert_select '#category-page', 'Подробное описание что такое пыльник рулевой тяги.'
  end

end
