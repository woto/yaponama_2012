# encoding: utf-8

require 'test_helper'

# TODO пока это тут, до момента пока окончательно не 
# разберусь с helper'ами и их тестированием

class TextInputTest < ActionDispatch::IntegrationTest
  test 'У kpp автомобиля должен быть правильный placeholder' do
    auth('+7 (111) 111-11-11', '1111111111')
    visit '/user/cars/new'
    click_link 'Характеристики'
    assert_equal "Механика, Автомат, Вариатор и т.д.", find('#car_kpp')['placeholder']
  end
end

