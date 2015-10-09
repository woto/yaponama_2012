require 'test_helper'

class DeliveriesTest < ActionDispatch::IntegrationTest

  test 'Не заполняем ни одного поля' do
    Capybara.reset!
    visit '/deliveries'
    click_button 'Рассчитать'
    assert has_css? '.form-horizontal'
    assert has_css? '.form-group.has-error', count: 2
    assert has_css? '#deliveries-calculate-result', text: 'Адрес доставки указан неверно.'
  end

  test 'Обслуживаемая область' do
    Capybara.reset!
    visit '/deliveries'
    fill_in 'street', with: 'Ленинский проспект'
    fill_in 'house', with: '1'
    click_button 'Рассчитать'
    assert has_text? 'Вариант 1'
  end

  test 'Не обслуживаемая область' do
    Capybara.reset!
    visit '/deliveries'
    fill_in 'street', with: 'Гончарная'
    fill_in 'house', with: '14'
    click_button 'Рассчитать'
    assert has_text? 'Не обслуживаемая область'
  end

  test 'Автоматический рассчет в зависимости от удаленности' do
    Capybara.reset!
    visit '/deliveries'
    fill_in 'street', with: 'Коккинаки'
    fill_in 'house', with: '6'
    click_button 'Рассчитать'
    assert has_text? 'составляет 144 руб.'
  end

  test 'Превышено расстояние от центрального склада' do
    Capybara.reset!
    visit '/deliveries'
    fill_in 'street', with: 'Сиреневый бульвар'
    fill_in 'house', with: '12'
    click_button 'Рассчитать'
    assert has_text? 'Превышено расстояние от центрального склада'
  end
end


