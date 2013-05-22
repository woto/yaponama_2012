# encoding: utf-8

require 'test_helper'

class GridChecboxTest < ActionDispatch::IntegrationTest
  test "Если мы чекбоксим товар и вкючаем фильтр отображения только выделенных элементов, то должен остаться только выделенный элемент" do

    # Логинимся
    auth('1231231231', '1231231231')

    # Получаем список товаров в корзине
    visit '/user/products/status/incart'

    # Убеждаемся, что есть три товара
    page.assert_selector("tr", count: 3)

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
    page.assert_selector("tr", count: 2)

    Capybara.reset_session!

  end

  test "Если мы выделяем элемент, то после обновления страницы браузера элемент должен остаться выделенным" do
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

    Capybara.reset_session!

  end

end
