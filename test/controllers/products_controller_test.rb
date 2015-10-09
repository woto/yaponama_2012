require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  class FakeController < ApplicationController
    include ProductSerializer
  end

  test 'Искомый артикул отсутствует' do
    get :new, catalog_number: 473983473298432894
    assert_response 404
  end

  test 'Если сервер прайсов не доступен' do
    old = Rails.configuration.price['host']
    Rails.configuration.price['host'] = 'example.com'
    get :new, catalog_number: 238943923849853240382
    assert_response 503
    Rails.configuration.price['host'] = old
  end

  test 'Проверяем наличие класса icheck' do
    get :new, catalog_number: '2102'
    assert_select '#products .icheck'
  end

  test 'Если по номеру найден один производитель, то не показываем pills' do
    get :new, catalog_number: 'proverkasearch'
    assert_select 'ul.nav.nav-pills', false
  end

  test 'Если по номеру найдены более одного производителя, то показываем pills' do
    get :new, catalog_number: '2102'
    assert_select 'ul.nav.nav-pills' do
      assert_select 'li.active' do
        assert_select 'a[href="#nissan"][data-toggle="tab"]', text: 'NISSAN'
      end
      assert_select 'li:not(.active)' do
        assert_select 'a[href="#kia"][data-toggle="tab"]', text: 'KIA'
        assert_select 'a[href="#ki"][data-toggle="tab"]', text: 'KI'
      end
    end
  end

  test 'Проверяем наличие самих .tab-pane с производителями' do
    get :new, catalog_number: '2102'
    assert_select '.tab-content' do
      assert_select '.tab-pane[itemscope][itemtype="http://schema.org/Product"]' do
        assert_select '#nissan.fade.in.active', count: 1
        assert_select '#kia.fade:not(.in.active)'
        assert_select '#ki.fade:not(.in.active)'
      end
    end
  end

  test 'Проверяем .panel-heading в .tab-pane' do
    get :new, catalog_number: '2102'
    assert_select '#kia.tab-pane' do
      assert_select '.panel' do
        assert_select '.panel-heading' do
          assert_select 'h3.panel-title' do
            assert_select 'a[href="/categories"]:nth-child(1)', text: 'Запчасти'
            assert_select 'a[href="/categories/926511968-bamper-zadniy"]:nth-child(3)', text: 'БАМПЕР ЗАДНИЙ'
            assert_select 'a[href="#kia"]:nth-child(5)' do
              assert_select '[itemprop="name"]', '2102 (KIA)'
            end
          end
        end
      end
    end
  end

  test 'Проверяем в .panel-body отображение артикула и брнеда' do
    get :new, catalog_number: 'proverkasearch'
    assert_select '#proizvodit.tab-pane' do
      assert_select '.panel' do
        assert_select '.panel-body' do
          assert_select 'h3' do
            assert_select 'small', text: 'Производитель:'
            assert_select 'b[itemprop="brand"]', 'ПРОИЗВОДИТ'
            assert_select 'small', text: '(ПРОИЗВОДИТЕЛЬ)'
          end
          assert_select 'h3' do
            assert_select 'small', 'Артикул:'
            assert_select 'b', 'PROVERKASEARCH'
            assert_select 'small', '(PROVERKA_SEARCH)'
          end
        end
      end
    end
  end

  test 'Проверяем заполнение заголовка у панели' do
    get :new, catalog_number: '2102'
    assert_select '[itemscope]' do
      assert_select '[itemprop="name"]', /2102 \(NISSAN\)/
    end
  end


  test 'Ищем товар 2. У него производители TOYOTA и TY. Должны сгруппироваться в TOYOTA' do
    get :new, catalog_number: 2
    assert_select '#toyota'
    assert_select '#ty', false
    assert_select '#toyota' do
      assert_select 'p', text: '1, 22'
    end
  end

  test 'Ищем замены 2 с производителем TOYOTA, находим только 2 - TOYOTA' do
    get :new, catalog_number: 2, manufacturer: 'TOYOTA', replacements: '1'
    assert_match '1 - 1 руб.', response.body
  end

  test 'Ищем замены 2 без производителя, находим и TOYOTA и TY сгруппированным' do
    get :new, catalog_number: 2, replacements: '1'
    assert_match '1 - 17 руб.', response.body
  end

  test 'Ищем деталь grouptest123, находим и group.test.123 - Conglomerate child, и group-test-123 - Conglomerate сгруппированными с минимальной ценой (группировка происходит на стороне интернет магазина)' do
    get :new, catalog_number: 'grouptest123'
    assert_select 'b', text: 'Conglomerate'
    assert_select 'small', text: '(CONGLOMERATE CHILD)'
    assert_select 'b', text: 'GROUPTEST123'
    assert_select 'small', text: '(GROUP-TEST-123, GROUP.TEST.123)'
    assert_select '*', text: /3 624 руб/
  end

  test 'Деталь 838383 внесена как 838383 и 83-83.83 с производителями ОРИГИНАЛ и СИНОНИМ, на сервере прайсов должны слиться' do
    get :new, catalog_number: 838383
    assert_select "div[id='original']" do
      assert_select 'p', 'НАЗВАНИЕ СИНОНИМА, НАЗВАНИЕ ОРИГИНАЛА'
      assert_select 'small', '(СИНОНИМ)'
      assert_select 'small', '(83-83.83)'
    end
  end

  test 'Проверяем, что PriceMate.fill_titles берет названия из нужных столбцов и они правильно выводятся в результатах поиска' do
    get :new, catalog_number: 'titles-test'
    assert_select '[itemprop=description]', 'TITLE, TITLE_EN, DESCRIPTION, APPLICABILITY, PARTS_GROUP'
  end

  test 'Если сервер прайсов отдает нам деталь без производителя, то не должно быть 500 ошибки. Производитель должен подмениться на ОРИГИНАЛ' do
    get :new, catalog_number: '543385'
    assert_select "div[id='original']"
  end

  test 'Если spare_info имеет заполненный hstore, то он должен отобразиться в виде таблицы' do
    get :new, catalog_number: '2103'
    assert_select "table", html: /.*Свойство1.*Значение1/m
  end

  test 'Тестируем разметку с 1-м изображением товара' do
    get :new, catalog_number: '2103'
    assert_select '#products' do
      assert_select '#ki' do
        assert_select '.image' do
          assert_select '#gallery-carousel.carousel.slide' do
            assert_select 'ol.carousel-indicators', false
            assert_select '.carousel-inner.gallery' do
              assert_select '.item.active', 1 do
                assert_select 'a' do
                  assert_select "img[alt='2103 (KI)'].text-center"
                end
              end
            end
          end
        end
      end
    end
  end

  test 'Тестируем разметку с более 1-м изображением товара' do
    get :new, catalog_number: '2103'
    assert_select '#products' do
      assert_select '#mitsubishi' do
        assert_select '.image' do
          assert_select '#gallery-carousel.carousel.slide' do
            assert_select 'ol.carousel-indicators > li', 2 do |elements|
              elements.each_with_index do |element, index|
                case index
                when 0
                  assert_select 'li[data-target="#gallery-carousel"][data-slide-to="0"].active'
                when 1
                  assert_select 'li[data-target="#gallery-carousel"][data-slide-to="1"]'
                end
              end
            end
            assert_select '.carousel-inner.gallery > div', 2 do |elements|
              elements.each_with_index do |element, index|
                case index
                when 0
                  assert_select '.item.active' do
                    assert_select 'a[href="http://test.host:80/uploads/spare_info/image1/410347112/1.png"]' do
                      assert_select 'img.text-center[src="http://test.host:80/uploads/spare_info/image1/410347112/fill_thumb_1.png"][alt="2103 (MITSUBISHI)"]'
                    end
                  end
                when 1
                  assert_select 'a[href="http://test.host:80/uploads/spare_info/image2/410347112/2.png"]' do
                    assert_select 'img.text-center[src="http://test.host:80/uploads/spare_info/image2/410347112/fill_thumb_2.png"][alt="2103 (MITSUBISHI)"]'
                  end
                end
              end

            end
          end
        end
      end
    end
  end

  test 'Если spare_info имеет file1, то должна отобразиться ссылка на его скачивание' do
    get :new, catalog_number: '2103'
    assert_select "a", text: '1.bin'
  end

  test 'Проверяем заполнение :replacements' do
    get :new, catalog_number: '2102'
    replacements = assigns(:formatted_data)[0][1][1][1][:replacements]
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:new_num_from])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:new_num_to])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:same_num_from])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:same_num_to])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:repl_num_from])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:repl_num_to])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:part_num_from])
    assert_equal({spare_infos(:toyota_3310) => []}, replacements[:part_num_to])
  end

  test 'Даже если у нас отсутствуют замены в PostreSQL, то набор ключей всё равно должен присутствовать' do
    get :new, catalog_number: '543385'
    replacements = assigns(:formatted_data)[0][1][0][1][:replacements]
    assert_equal({}, replacements[:new_num_from])
    assert_equal({}, replacements[:new_num_to])
    assert_equal({}, replacements[:same_num_from])
    assert_equal({}, replacements[:same_num_to])
    assert_equal({}, replacements[:repl_num_from])
    assert_equal({}, replacements[:repl_num_to])
    assert_equal({}, replacements[:part_num_from])
    assert_equal({}, replacements[:part_num_to])
  end

  test 'Проверяем визуальное представление замен' do
    get :new, catalog_number: '3310'
    assert_select '.new_num_from' do
      assert_select 'h5', text: 'Просматриваемый вами товар ранее поставлялся производителем под номером:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.new_num_to' do
      assert_select 'h5', text: 'Просматриваемый вами товар теперь поставляется производителем под номером:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.same_num_from' do
      assert_select 'h5', text: 'Просматриваемый вами товар так же маркируется производителем как:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.same_num_to' do
      assert_select 'h5', text: 'Просматриваемый вами товар так же маркируется производителем как:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.repl_num_from' do
      assert_select 'h5', text: 'Просматриваемый вами товар является заменой для следующих номеров:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.repl_num_to' do
      assert_select 'h5', text: 'Просматриваемый вами товар можно заменить следующими номерами:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.part_num_from' do
      assert_select 'h5', text: 'Просматриваемый вами товар содержит следующие товары:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.part_num_to' do
      assert_select 'h5', text: 'Просматриваемый вами товар входит в состав следующих товаров:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
  end

  test 'Проверяем наличие разметки модального окна и ссылки для его вызова, в случае наличия замен' do
    get :new, catalog_number: '3310'
    assert_select '#deliveries_place_309456473' do
      assert_select 'a[data-toggle="modal"][data-target="#replacements_deliveries_place_309456473"]'
    end
    assert_select '#replacements_deliveries_place_309456473.modal'
  end

  test 'Если нет наличия и замен, то модальное окно отсутствует' do
    get :new, catalog_number: '3310'
    assert_select '#deliveries_place_908005739.modal', false
  end

  test 'Если есть наличие и замены, то модальное окно все равно не показывается' do
    get :new, catalog_number: '2102'
    assert_equal deliveries_places(:first), warehouses(:infiniti_3310).place
    assert_equal deliveries_places(:first), warehouses(:nissan_2102).place
    assert_select '#replacements_deliveries_place_309456473', false
  end

  test 'Проверяем, строчку с заменами на предмет отображения минимальной цены' do
    get :new, catalog_number: 'REPLMINCOST1'
    assert_select '#deliveries_place_309456473' do
      assert_select 'h4', text: /Динамо,\s+в наличии 2 замены, от 2 492 руб./
    end
  end

  test 'PriceMate.min_days and PriceMate.max_days' do
    brand = Defaults.brand
    spare_catalog = Defaults.spare_catalog
    get :new, catalog_number: 'min_max_days'
    sample = [["MINMAXDAYS", [["ОРИГИНАЛ", {:brand=>brand, :offers=>[{:country=>"Москва", :min_days=>1, :max_days=>1, :probability=>55, :retail_cost=>2423, :count=>5, :title=>"", :delivery=>"Москва", :income_cost=>1616, :supplier_id=>1, :price_setting_id=>1, :tech=>"Авториф, Прайс, 1615.5"}, {:country=>"Москва", :min_days=>2, :max_days=>2, :probability=>55, :retail_cost=>7842, :count=>5, :title=>"", :delivery=>"Москва", :income_cost=>7842, :supplier_id=>1, :price_setting_id=>2, :tech=>"Авториф, Прайс 2, 7842.0"}], :min_days=>1, :max_days=>2, :min_cost=>2423, :max_cost=>7842, :titles=>{"TITLE"=>2}, :manufacturer_origs=>{}, :catalog_number_origs=>{"MIN_MAX_DAYS"=>2}, :weights=>{}, :title=>"TITLE", :keyword=>"MINMAXDAYS", :phrases=>[], :catalog=>spare_catalog, :replacements=>{:new_num_from=>{}, :new_num_to=>{}, :same_num_from=>{}, :same_num_to=>{}, :repl_num_from=>{}, :repl_num_to=>{}, :part_num_from=>{}, :part_num_to=>{}}, :warehouses => {}}]]]]
    assert_equal(sample, assigns(:formatted_data))
  end

  test 'Проверяем отображение сроков PriceMate.min_days and PriceMate.max_days' do
    get :new, catalog_number: 'min_max_days', replacements: '1'
    assert_select '*', /1 - 2 дн./
  end

  test 'PriceMate.weights' do
    get :new, catalog_number: 'WEIGHTGRAMS'
    assert_select 'h3', 'Сколько весит'
    assert_select '*', /Масса: 0.5 кг./
  end

  test 'PriceMate.warehouses' do
    get :new, catalog_number: 's4 005'
    assert_select '*', text: /5 500 руб. в наличии 1 шт./
  end

  test 'Проверяем разметку формы' do
    get :new, catalog_number: 'proverka_search'
    assert_select '#form-PROVERKASEARCH-proizvodit[action="/user/products"][data-remote="true"][method="post"]'
  end

  test 'У магазина должна быть ссылка контакты' do
    get :new, catalog_number: 'S4 005'
    assert_select '#deliveries_place_309456473.deliveries_place' do
      assert_select 'a[window-dialog="/faqs/1069"][href="/faqs/1069"]', text: 'контакты'
    end
  end

  test 'Проверяем отображение наличия' do
    get :new, catalog_number: 'S4 005'
    assert_select '#deliveries_place_309456473.deliveries_place' do
      assert_select '.radio:not(.disabled)' do
        assert_select 'label' do
          assert_select 'input#offer_deliveries_place_309456473[type="radio"][name="offer"]:not([disabled])'
          assert_select 'h4' do
            assert_select 'img.metro'
            assert_select '*', text: /Динамо,\s+5 500 руб. в наличии 1 шт./
          end
        end
      end
    end
  end

  test 'Проверяем отображение отсутствующей позиции' do
    get :new, catalog_number: 'S4 005'
    assert_select '#deliveries_place_908005739.deliveries_place' do
      assert_select '.radio.disabled' do
        assert_select 'label' do
          assert_select 'input[type="radio"][name="offer"][disabled]'
          assert_select 'h4.text-muted' do
            assert_select 'img.metro'
            assert_select '*', text: /Медведково,\s+нет в наличии/
          end
        end
      end
    end
  end

  test 'Проверяем отображение замен на отсутствующую позицию' do
    get :new, catalog_number: '0092S40050'
    assert_select '#deliveries_place_309456473.deliveries_place' do
      assert_select '.radio.disabled' do
        assert_select 'label' do
          assert_select 'input[type="radio"][name="offer"][disabled]'
          assert_select 'h4' do
            assert_select 'img.metro'
            assert_select 'a[href="#"]', text: /Динамо,\s+в наличии 2 замены/
          end
        end
      end
    end
  end

  test 'Проверяем отображение формы добавления в корзину и заказаной позиции' do
    travel_to Time.new(2015, 10, 04, 00, 00, 00) do
      get :new, catalog_number: 'proverka_search'
      assert_select '#deliveries_place.deliveries_place' do
        assert_select ".radio" do
          assert_select "label" do
            assert_select 'input#offer_deliveries_place[type="radio"][name="offer"]'
            assert_select 'h4' do
              assert_select '*', text: /Под заказ,\s+743 руб.\s+доставка\s+4 окт./
              assert_select 'small' do
                assert_select 'a[window-dialog="/deliveries"][href="/deliveries"]', text: 'узнать стоимость доставки'
              end
              assert_select 'span.text-xs' do
                assert_select '*', text: /Акция/
                assert_select '*', text: /219 руб./
                assert_select 'a[href="/faqs/1074"][window-dialog="/faqs/1074"]', text: 'подробнее...'
              end
            end
          end
        end
      end
    end
  end

  test 'Если товара нет в корзине, то отображается кнопка Добавить в корзину' do
    get :new, catalog_number: 'proverka_search'
    assert_select 'input#submit-PROVERKASEARCH-proizvodit[type=submit][name=proizvodit]'
  end

  test 'Если товар уже находится в корзине, то кнопки добавления в корзину нет' do
    sign_in users(:user)
    get :new, catalog_number: 'product_incart'
    assert_select 'input#submit-PROVERKASEARCH-proizvodit[type=submit][name=proizvodit]', false
  end

  test 'Если товар уже находится в корзине, то отображется текст об этом' do
    sign_in users(:user)
    get :new, catalog_number: 'product_incart'
    assert_select 'h4#incart-PRODUCTINCART-nissan', text: 'Товар уже находится в корзине, перейти в корзину'
  end

  test 'Ну и если товара в корзине у пользователя нет, то текст о наличии товара в корзине соответственно не показывается' do
    get :new, catalog_number: 'product_incart'
    assert_select 'h4#incart-PRODUCTINCART-nissan', false
  end

  test 'Пустой переданный offer должен привести к отображению справочной информации' do
    xhr :post, :create
    assert_template 'please_choose_offer'
  end

  test 'Переданный правильный offer должен добавить товар покупателю со статусом incart' do
    user = users(:guest)
    sign_in(user)
    brand_id = brands(:nissan).id
    cntrl = FakeController.new

    assert_difference -> {user.products.count} do
      xhr :post, :create, offer: cntrl.serialize_product(catalog_number: 'catalog_number', brand_id: brand_id, deliveries_place_id: nil, quantity_ordered: 1, sell_cost: 1, title: 1, titles: [1], buy_cost: 1, quantity_available: 1, probability: 1, min_days: 1, max_days: 1)
    end
    assert_equal 'incart', assigns(:resource).status
  end

  test 'Переданный неправильно offer должен сгенерировать исключение' do
    assert_raise ActiveRecord::RecordInvalid do
      xhr :post, :create, offer: '123'
    end
  end

  test 'Проверяем отображение формы, когда заказной позиции нет, но есть в наличии в каком-нибудь из магазинов' do
    #TODO это получится реализовать только когда буду работать с 404 страницей
    skip
  end

end
