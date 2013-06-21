# encoding: utf-8

require 'test_helper'

class GridChecboxTest < ActionDispatch::IntegrationTest
  test "Если мы чекбоксим товар и вкючаем фильтр отображения только выделенных элементов, то должен остаться только выделенный элемент" do

    Capybara.reset!

    # Логинимся
    auth('1231231231', '1231231231')

    # Получаем список товаров в корзине
    visit '/user/products/status/incart'

    # Убеждаемся, что есть три товара
    page.has_selector?("tr", count: 3)

    # Выбираем первый
    first('input[type="checkbox"]').click
    assert page.has_css?('input[type="checkbox"][checked]')

    # Открываем окно фильтрации по чекбоксу
    first('.icon-filter').click
    assert page.has_css?('#grid_checkbox_checkbox_1')

    # Щелкаем в окне на выделенных - Да
    first('#grid_checkbox_checkbox_1').click

    # Сабмитим форму
    first("#checkbox_filter.modal div.modal-footer input.btn").click

    # Убеждаемся, что в результате остался один товар
    page.has_selector?("tr", count: 2)

  end

  test "Если мы выделяем элемент, то после обновления страницы браузера элемент должен остаться выделенным" do

    Capybara.reset!

    # Логинимся
    auth('1231231231', '1231231231')

    visit '/user/products/status/incart'

    # Убеждаемся, что есть три товара
    page.assert_selector("tr", count: 3)

    # Выбираем первый
    first('input[type="checkbox"]').click
    assert page.has_css?('input[type="checkbox"][checked]')

    # Обновляем страницу браузера
    visit(page.driver.browser.current_url)

    # Убеждаемся, что товар по-прежнему выделен
    assert page.has_css?('input[type="checkbox"][checked]')

  end

  test "Тестируем правильно отображение постраничной навигации если кол-во элементов превышает одну страницу" do

    Capybara.reset!

    # Логинимся
    auth('1231231231', '1231231231')

    # Получаем список товаров в корзине
    visit '/user/products/status/incart'

    # Убеждаемся, что есть три товара
    page.assert_selector("tr", count: 3)

    # Щелкаем на ссылке для ввода нового кол-ва товаров на странице
    find('.dashed').click

    # Дожидаемся появления окна для ввода нового кол-ва
    assert page.has_css?('.in')

    # Укаываем - 1 на страницу
    find('input#grid_per_page').set('1')

    # Отправляем на сервер
    find('[name=per_page]').click

    # Убеждаемся, что на странице остался 1 товар
    page.assert_selector("tr", count: 2)

  end
end
