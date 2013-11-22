# encoding: utf-8
#
require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'При добавлении нового автомобиля должен быть выделен check_box vin и отображено соответствующее поле для ввода vin кода' do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/cars/new'

    assert has_checked_field? 'car_vin_or_frame_vin'

    assert has_field? 'car_vin'
  end

  test 'При редактировании автомобиля с указанным frame кодом должен быть выделен check_box frame и отображено поле для редактироваия frame кода' do

    auth('+5 (555) 555-55-55', '5555555555')
    car = cars(:otto).id
    visit "/user/cars/#{car}/edit"

    assert has_checked_field? 'car_vin_or_frame_frame'

    assert has_field? 'car_frame'

  end

  test 'При щелчке на frame/vin должны показываться соответствующие поля frame/vin' do
    auth('+7 (333) 333-33-33', '3333333333')
    visit '/user/cars/new'

    choose 'car_vin_or_frame_frame'

    assert has_field? 'car_frame'

    choose 'car_vin_or_frame_vin'

    assert has_field? 'car_vin'
  end

end
