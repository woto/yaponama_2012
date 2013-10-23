# encoding: utf-8

require 'test_helper'
require 'controllers/attributes/cars_attributes'

class CarsControllerTest < ActionController::TestCase
  include CarsAttributes

  test 'Добавление нового автомобиля с новым брендом, моделью, поколением, модификацией' do
    cookies['auth_token'] = somebodies(:mark).auth_token

    post :create, :car => new_car, :return_path => '/user'

    assert_equal 'new brand', Brand.last.name
    assert_equal 'new model', Model.last.name
    assert_equal 'new generation', Generation.last.name
    assert_equal 'new modification', Modification.last.name

  end

  test 'Проверка правильности отображения и заполнения полей после отправки пустого (обязательного поля) значения бренда при обновлении' do
    cookies['auth_token'] = somebodies(:mark).auth_token

    post :update, :id => 645198450, :car => update_empty, :return_path => '/user'

    assert_select '#car_brand_attributes_name'
    assert_select '#car_model_attributes_name'
    assert_select '#car_generation_attributes_name'
    assert_select '#car_modification_attributes_name'

  end

end
