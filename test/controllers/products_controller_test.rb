require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

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

  test 'Редактировать и перезаказывать мы можем только свои товары' do
    skip
  end

  test 'Просто поиск' do
    skip
  end

  # РЕДАКТИРОВАНИЕ

  test 'Не нашли уведомление о редактировании на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '.alert', /Обратите\ внимание!\ Производится\ редактирование\ позиции\.\ После\ добавления\ товара\ в\ корзину,\ товар\ 1\ \(SENDING1\)\ будет\ изменен\ на\ вновь\ добавленный\.\ Если\ это\ не\ то\ что\ вы\ хотите,\ то\ просто\ перейдите\ на\ главную\ страницу\ и\ воспользуйтесь\ формой\ поиска\ как\ обычно\./
  end

  test 'Не нашли результаты поиска на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '.page-header', 'NISSAN, TOYOTA, 11111, 1111, 111 1'
  end

  test 'Должен быть введен изначальный кат. ном. на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '#catalog_number[value=?]', '1'
  end

  test 'Форма для ввода артикула должна быть в ед. экземпляре на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '.search-form', 1
  end

  test 'Перезаказываемый товар должен отсутствовать на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '#product_id:not([value])', true
  end

  test 'Кнопка Форма должна отсутствовать на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select "a[href='#modal_form']", false
  end

  test 'Урл формы должен быть правильный на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '.search-form[action=?]', "/user/products/#{products(:sending1).id}/edit"
  end

  test 'При поиске нового артикула проверяем что форма заполнена новым значением на странице редактирования' do
    get :edit, id: products(:sending1), catalog_number: '1111111111'
    assert_select '#catalog_number[value=?]', '1111111111'
  end

  # ПЕРЕЗАКАЗ

  test 'Не нашли уведомления о перезаказе на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '.alert', /Обратите\ внимание!\ Добавляемая\ позиция\ при\ дальнейшей\ работе\ будет\ отражена\ как\ перезаказанная\ с\ 1\ \(SENDING1\)\.\ Если\ это\ не\ то\ что\ вы\ хотите,\ то\ просто\ перейдите\ на\ главную\ страницу\ и\ воспользуйтесь\ формой\ поиска\ как\ обычно\./
  end

  test 'Не нашли результаты поиска на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '.page-header', 'NISSAN, TOYOTA, 11111, 1111, 111 1'
  end

  test 'Должен быть введен изначальный кат. ном. на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '#catalog_number[value=?]', '1'
  end

  test 'Форма для ввода артикула должна быть в ед. экземпляре на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '.search-form', 1
  end

  test 'Перезаказываемый товар должен присутствовать на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '#product_id[value=?]', products(:sending1).id.to_s
  end

  test 'Кнопка Форма должна отсутствовать на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select "a[href='#modal_form']", false
  end

  test 'URL формы должен быть правильный на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '.search-form[action=?]', "/user/products/new"
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
    assert_select 'small', text: '(CONGLOMERATE, CONGLOMERATE CHILD)'
    assert_select 'b', text: 'GROUPTEST123'
    assert_select 'small', text: '(GROUP-TEST-123, GROUP.TEST.123)'
    assert_select '*', text: /3 624 руб/
  end

  test 'Деталь 838383 внесена как 838383 и 83-83.83 с производителями ОРИГИНАЛ и СИНОНИМ, на сервере прайсов должны слиться' do
    get :new, catalog_number: 838383
    assert_select "div[id='original']" do
      assert_select 'p.other-names', 'НАЗВАНИЕ СИНОНИМА, НАЗВАНИЕ ОРИГИНАЛА'
      assert_select 'small.other-brands', '(СИНОНИМ)'
      assert_select 'small.other-catalog-numbers', '(83-83.83)'
    end
  end

  test 'Проверяем, что PriceMate.fill_titles берет названия из нужных столбцов и они правильно выводятся в результатах поиска' do
    get :new, catalog_number: 'titles-test'
    assert_select '.other-names', 'TITLE, TITLE_EN, DESCRIPTION, APPLICABILITY, PARTS_GROUP'
  end

  test 'Если сервер прайсов отдает нам деталь без производителя, то не должно быть 500 ошибки. Производитель должен подмениться на ОРИГИНАЛ' do
    get :new, catalog_number: '543385'
    assert_select "div[id='original']"
  end

  test 'Ссылки' do
    skip
    # Протестировать ссылки на замены, купить и т.д.
  end

  test 'Если spare_info имеет заполненный hstore, то он должен отобразиться в виде таблицы' do
    get :new, catalog_number: '2103'
    assert_select "table", html: /.*Свойство1.*Значение1/m
  end

  test 'Если spare_info имеет image1, то она должна отобразиться' do
    get :new, catalog_number: '2103'
    assert_select "[alt='2103 (KI)']"
  end

  test 'Если spare_info имеет file1, то должна отобразиться ссылка на его скачивание' do
    get :new, catalog_number: '2103'
    assert_select "a", text: '1.bin'
  end

  test 'Проверяем заполнение :replacements' do
    get :new, catalog_number: '2102'
    replacements = assigns(:formatted_data)[0][1][1][1][:replacements]
    assert_equal [spare_infos(:toyota_3310)], replacements[:new_num_from]
    assert_equal [spare_infos(:toyota_3310)], replacements[:new_num_to]
    assert_equal [spare_infos(:toyota_3310)], replacements[:same_num_from]
    assert_equal [spare_infos(:toyota_3310)], replacements[:same_num_to]
    assert_equal [spare_infos(:toyota_3310)], replacements[:repl_num_from]
    assert_equal [spare_infos(:toyota_3310)], replacements[:repl_num_to]
    assert_equal [spare_infos(:toyota_3310)], replacements[:part_num_from]
    assert_equal [spare_infos(:toyota_3310)], replacements[:part_num_to]
  end

  test 'Даже если у нас отсутствуют замены в PostreSQL, то набор ключей всё равно должен присутствовать' do
    get :new, catalog_number: '543385'
    replacements = assigns(:formatted_data)[0][1][0][1][:replacements]
    assert_equal [], replacements[:new_num_from]
    assert_equal [], replacements[:new_num_to]
    assert_equal [], replacements[:same_num_from]
    assert_equal [], replacements[:same_num_to]
    assert_equal [], replacements[:repl_num_from]
    assert_equal [], replacements[:repl_num_to]
    assert_equal [], replacements[:part_num_from]
    assert_equal [], replacements[:part_num_to]
  end

  test 'Проверяем визуальное представление замен' do
    get :new, catalog_number: '3310'
    assert_select '.new_num_from' do
      assert_select 'h4', text: 'Просматриваемый вами номер ранее поставлялся производителем под номером:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.new_num_to' do
      assert_select 'h4', text: 'Просматриваемый вами номер был заменен производителем на номер:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.same_num_from' do
      assert_select 'h4', text: 'Просматриваемый вами номер так же маркируется как:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.same_num_to' do
      assert_select 'h4', text: 'Просматриваемый вами номер так же маркируется как:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.repl_num_from' do
      assert_select 'h4', text: 'Просматриваемый вами номер является заменой для следующих номеров:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.repl_num_to' do
      assert_select 'h4', text: 'Просматриваемый вами номер можно заменить следующими номерами:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.part_num_from' do
      assert_select 'h4', text: 'Просматриваемый вами товар содержит следующие товары:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
    assert_select '.part_num_to' do
      assert_select 'h4', text: 'Просматриваемый вами товар входит в состав следующих товаров:'
      assert_select 'a[href="/user/products/new?catalog_number=2102"]'
    end
  end

  test 'PriceMate.min_days and PriceMate.max_days' do
    brand = Defaults.brand
    spare_catalog = Defaults.spare_catalog
    get :new, catalog_number: 'min_max_days'
    sample = [["MINMAXDAYS", [["ОРИГИНАЛ", {:titles=>{"TITLE"=>2}, :manufacturer_origs=>{}, :catalog_number_origs=>{"MIN_MAX_DAYS"=>2}, :weights=>{}, :min_days=>1, :max_days=>2, :min_cost=>2423, :max_cost=>7842, :offers=>[{:country=>"Москва", :min_days=>1, :max_days=>1, :probability=>55, :retail_cost=>2423, :count=>5, :title=>"", :delivery=>"Москва", :income_cost=>1616, :supplier_id=>1, :price_setting_id=>1, :tech=>"Авториф, Прайс, 1615.5"}, {:country=>"Москва", :min_days=>2, :max_days=>2, :probability=>55, :retail_cost=>7842, :count=>5, :title=>"", :delivery=>"Москва", :income_cost=>7842, :supplier_id=>1, :price_setting_id=>2, :tech=>"Авториф, Прайс 2, 7842.0"}], :brand=>brand, :title=>"TITLE", :keyword=>"MINMAXDAYS", :phrases=>[], :catalog=>spare_catalog, :replacements=>{:new_num_from=>[], :new_num_to=>[], :same_num_from=>[], :same_num_to=>[], :repl_num_from=>[], :repl_num_to=>[], :part_num_from=>[], :part_num_to=>[]}}]]]]
    assert_equal(sample, assigns(:formatted_data))
  end

end
