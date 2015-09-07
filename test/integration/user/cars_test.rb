require 'test_helper'

class User::CarsTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.reset!
  end

  test 'При добавлении нового автомобиля должен быть выделен check_box vin и отображено соответствующее поле для ввода vin кода' do
    visit '/user/cars/new'
    assert has_checked_field? 'user_car_vin_or_frame_vin'
    assert has_field? 'user_car_vin'
  end

  test 'При редактировании автомобиля с указанным frame кодом должен быть выделен check_box frame и отображено поле для редактироваия frame кода' do
    car = user_cars(:otto).id
    visit "/user/cars/#{car}/edit"
    assert has_checked_field? 'user_car_vin_or_frame_frame'
    assert has_field? 'user_car_frame'
  end

  test 'При щелчке на frame/vin должны показываться соответствующие поля frame/vin' do
    visit '/user/cars/new'
    choose 'user_car_vin_or_frame_frame'
    assert has_field? 'user_car_frame'
    assert has_field? 'user_car_vin', visible: false
    choose 'user_car_vin_or_frame_vin'
    assert has_field? 'user_car_vin'
    assert has_field? 'user_car_frame', visible: false
  end

  test 'При щелчке на выпадающее меню выбора производителя мы должны видеть только оригиналы' do
    visit "/user/cars/new"
    execute_script %q($("input[rel='select2-brand']").select2('open'))
    assert has_text? "ACURA"
    assert has_no_text? "A.B.S."
  end

end
