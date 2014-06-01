# encoding: utf-8
#
require 'test_helper'

class GridChecboxTest < ActionDispatch::IntegrationTest
  test "Если мы чекбоксим товар и вкючаем фильтр отображения только выделенных элементов, то должен остаться только выделенный элемент" do

    Capybara.reset!

    # Логинимся
    auth('+7 (123) 123-12-31', '1231231231')

    # Получаем список товаров в корзине
    visit '/user/products/status/incart'

    # Убеждаемся, что отображается два товара
    first = products(:first_user_first_product)
    second = products(:first_user_second_product)

    assert has_css? "#product_#{first.id}"
    assert has_css? "#product_#{second.id}"

    # При заходе в корзину все товары должны быть отмеченными
    assert has_checked_field? "grid_item_ids_#{first.id}"
    assert has_checked_field? "grid_item_ids_#{second.id}"

    # Убираем выделение со второго
    uncheck "grid_item_ids_#{second.id}"

    assert has_checked_field? "grid_item_ids_#{first.id}"
    assert has_unchecked_field? "grid_item_ids_#{second.id}"

    # Открываем окно фильтрации по чекбоксу
    first('.fa-filter').click

    sleep 2
    assert has_text?('Фильтр для:')

    # Щелкаем в окне на выделенных - Да
    choose 'grid_filter_checkbox_checkbox_1'

    # Сабмитим форму
    first("#filter_checkbox.modal div.modal-footer input.btn").click

    # Убеждаемся, что в результате остался один товар
    assert has_css? "#product_#{first.id}"
    assert has_no_css? "#product_#{second.id}"
  end

  test "Если мы выделяем элемент, то после обновления страницы браузера элемент должен остаться выделенным" do

    Capybara.reset!

    # Логинимся
    auth('+7 (123) 123-12-31', '1231231231')

    visit '/user/products/status/incart'

    # Убеждаемся, что отображается два товара
    first = products(:first_user_first_product)
    second = products(:first_user_second_product)

    assert has_css? "#product_#{first.id}"
    assert has_css? "#product_#{second.id}"

    # Выбираем товар
    check "grid_item_ids_#{second.id}"
    assert has_checked_field? "grid_item_ids_#{second.id}"

    sleep 0.5

    # Обновляем страницу браузера
    visit(page.driver.browser.current_url)

    # Убеждаемся, что товар по-прежнему выделен
    assert has_checked_field? "grid_item_ids_#{second.id}"

  end

  test "Тестируем правильно отображение постраничной навигации если кол-во элементов превышает одну страницу" do

    Capybara.reset!

    # Логинимся
    auth('+7 (123) 123-12-31', '1231231231')

    # Получаем список товаров в корзине
    visit '/user/products/status/incart'

    # Убеждаемся, что отображается два товара
    first = products(:first_user_first_product)
    second = products(:first_user_second_product)

    assert has_css? "#product_#{first.id}"
    assert has_css? "#product_#{second.id}"

    # Щелкаем на ссылке для ввода нового кол-ва товаров на странице
    find('#grid-toolbar-per-page .btn').click

    # Дожидаемся появления окна для ввода нового кол-ва
    assert page.has_css?('.in')

    # Указываем - 1 на страницу
    find('input#grid_per_page').set('1')

    # Отправляем на сервер
    find('[name=per_page]').click

    # Убеждаемся, что на странице остался 1 товар
    assert has_css? ".product", count: 1

  end
end
