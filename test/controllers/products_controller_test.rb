# encoding: utf-8
#
require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test 'Искомый артикул отсутствует' do
    get :new, catalog_number: 473983473298432894
    assert_response 404
  end

  test 'Если сервер прайсов не доступен' do
    skip 'То отдается 503, придумать как написать тест'
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
    assert_select '#main .alert', "Обратите внимание! Производится редактирование позиции. После добавления товара в корзину, товар 1 (SENDING1) будет изменен на вновь добавленный. Если это не то что вы хотите, то просто перейдите на главную страницу и воспользуйтесь формой поиска как обычно."
  end

  test 'Не нашли результаты поиска на странице редактирования' do
    get :edit, id: products(:sending1)
    assert_select '.page-header', '11, 111, 1111, 11111, PARMA 1'
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
    assert_select '#main .alert', "Обратите внимание! Добавляемая позиция при дальнейшей работе будет отражена как перезаказанная с 1 (SENDING1). Если это не то что вы хотите, то просто перейдите на главную страницу и воспользуйтесь формой поиска как обычно."
  end

  test 'Не нашли результаты поиска на странице перезаказа' do
    get :new, product_id: products(:sending1)
    assert_select '.page-header', '11, 111, 1111, 11111, PARMA 1'
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
    assert_select '#TOYOTA'
    assert_select '#TY', false
    assert_select '#TOYOTA' do
      assert_select 'p', text: '1, 22'
    end
  end

  test 'Ищем замены 2 с производителем TOYOTA, находим только 2 - TOYOTA' do
    get :new, catalog_number: 2, manufacturer: 'TOYOTA', replacements: '1'
    assert_match '2 - 2 руб.', response.body
  end

  test 'Ищем замены 2 без производителя, находим и TOYOTA и TY сгруппированным' do
    get :new, catalog_number: 2, replacements: '1'
    assert_match '2 - 40 руб.', response.body
  end

  test 'Деталь 838383 внесена как 838383 и 83-83.83 с производителями ОРИГИНАЛ и СИНОНИМ, на сервере прайсов должны слиться' do
    get :new, catalog_number: 838383
    assert_select "div[id='ОРИГИНАЛ']" do
      assert_select 'p.other-names', 'НАЗВАНИЕ СИНОНИМА, НАЗВАНИЕ ОРИГИНАЛА'
      assert_select 'p.other-brands', 'СИНОНИМ'
      assert_select 'p.other-catalog-numbers', '83-83.83'
    end
  end


  test 'Ссылки' do
    skip
    # Протестировать ссылки на замены, купить и т.д.
  end

end
