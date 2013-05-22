# encoding: utf-8

require 'test_helper'

class GridChecboxTest < ActionDispatch::IntegrationTest
  test "Попытка написать тест для чекбоксов, используемых в Grid" do

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

  end
end
