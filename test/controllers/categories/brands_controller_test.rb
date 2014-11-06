require 'test_helper'

class Categories::BrandsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 348934' do
    get :index, category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ'
    assert_select '.breadcrumb', /^Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ$/m
    assert_select '#category-brands', /^MITSUBISHI\s+TOYOTA$/m
    #assert_select '#category-intro', 'Короткое описание что такое пыльник рулевой тяги.'
    assert_select '#category-page', 'Подробное описание что такое пыльник рулевой тяги.'
  end

  test 'Быстрый тест на содержание страницы 2398' do
    get :show, id: brands(:mitsubishi), category_id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ MITSUBISHI (рус. Митсубиси, Митсубиши)'
    assert_select '.breadcrumb', /^Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ\s+MITSUBISHI$/m
    assert_select '#category-models', /^Galant\s+Lancer\s+Lancer Ralliart$/m
  end

end
