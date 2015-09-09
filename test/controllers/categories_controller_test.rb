require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 23498234' do
    get :index
    assert_select '.page-header', 'ЗапчастиЭто тестовое вступление к странице Запчасти'
    assert_select '#categories-index-catalogs', /Батарея аккумуляторная \(4 шт.\)\s+Шина Грузовая \(1 шт.\)/m
    assert_select '.tree' do
      assert_select 'ul' do
        assert_select 'li.collapsible' do
          assert_select 'a', text: 'Рулевое управление'
          assert_select 'ul' do
            assert_select 'li.collapsible' do
              assert_select 'a', text: 'Рулевой редуктор, рулевая рейка'
              assert_select 'ul' do
                assert_select 'li' do
                  assert_select 'a[href=?]', category_path(spare_catalogs(:rulevaya_tyga)), html: 'РУЛЕВАЯ ТЯГА<small class="text-muted"> (2 шт.)</small>'
                end
              end
            end
          end
        end
      end
    end
  end

  test 'Быстрый тест на содержание страницы 348934' do
    get :show, id: spare_catalogs(:pylnik_rulevoi_reiki)
    assert_select '.page-header', 'ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ'
    assert_select '.breadcrumb', /^Главная\s+Запчасти\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ$/m
    assert_select '#categories-show-brands', /^ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI \(3 шт.\)\s+ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на TOYOTA \(1 шт.\)$/m
    #TODO переработать потом
    #assert_select '#category-intro', 'Короткое описание что такое пыльник рулевой тяги.'
    #assert_select '#category-page', 'Подробное описание что такое пыльник рулевой тяги.'
  end

  test 'Проверяем @discourse на :index' do
    get :index
    assert_equal ["Запчасти"], assigns(:discourse)
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: spare_catalogs(:bamper_zadniy)
    assert_equal ["БАМПЕР ЗАДНИЙ"], assigns(:discourse)
  end

  test 'Проверяем работу titles_as_string' do
    get :show, {id: spare_catalogs(:rulevaya_tyga), "q" => {"titles_as_string_cont"=>"itles_as_strin"}}
    assert_equal SpareInfo.where(id: spare_infos(:titles_as_string)).to_a, assigns(:spare_infos).to_a
  end

end
