require 'test_helper'

class Catalogs::ModelsControllerTest < ActionController::TestCase

  test 'Быстрый тест на содержание страницы 32492' do
    get :show, id: models(:galant)
    assert_select '.page-header', 'Запчасти на MITSUBISHI Galant (рус. Галант)'
    assert_select '.breadcrumb', /^Главная.*Каталоги.*MITSUBISHI.*Galant$/m

    assert_select '.tree' do
      assert_select 'ul' do
        assert_select 'li.collapsible' do
          assert_select 'a', text: 'Рулевое управление'
          assert_select 'ul' do
            assert_select 'li.collapsible' do
              assert_select 'a', text: 'Рулевой редуктор, рулевая рейка'
              assert_select 'ul' do
                assert_select 'li' do
                  assert_select 'a[href=?]', category_model_path(spare_catalogs(:rulevaya_tyga), models(:galant)), html: 'РУЛЕВАЯ ТЯГА<div class="hidden"> на MITSUBISHI Galant</div>
<small class="text-muted"> (1 шт.)</small>'
                end
              end
            end
          end
        end
      end
    end

    #TODO переработать
    #assert_select '#catalogs-model-generations', 'ЗАПЧАСТИ на MITSUBISHI Galant 2008 - 2013, 9 поколение [2-й рестайлинг]'
    #assert_select '#catalogs-model-content', 'Описание Галанта.'
    #
    #TODO переработать
    #assert_select '#best-parts-list', /3310 \(INFINITI\) ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ на MITSUBISHI Galant.*3310 \(TOYOTA\) РУЛЕВАЯ ТЯГА на MITSUBISHI Galant.*2102 \(NISSAN\) САЙЛЕНТБЛОК на MITSUBISHI Galant.*/m
  end

  test 'Проверяем @discourse на :show' do
    get :show, id: models(:teana)
    assert_equal ['Запчасти на NISSAN teana'], assigns(:discourse)
  end

end
