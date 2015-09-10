require 'test_helper'

# TODO пока это тут, до момента пока окончательно не
# разберусь с helper'ами и их тестированием

class TextInputTest < ActionDispatch::IntegrationTest
  test 'Проверка функциональности вложенного в модель placeholder' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    visit '/user/cars/new'
    click_link 'Характеристики'
    assert_equal "Механика, Автомат, Вариатор и т.д.", find('#car_kpp')['placeholder']
  end

  test 'Проверка функциональности placeholder' do
    Capybara.reset!
    auth('+7 (111) 111-11-11', '1111111111')
    visit '/user/postal_addresses/new'
    assert_equal 'Номер квартиры или офиса', find('#postal_address_room')['placeholder']
  end

  test 'Проверка функциональности label' do
    skip
  end
end

