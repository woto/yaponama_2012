# encoding: utf-8
#
require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test 'Если у пользователя выставлен code_1, и создается новый автомобиль, то он должен скопироваться на car. А также т.к. этот автомобиль новый, то должен выставиться creation_reason как и у somebody' do
    somebody = somebodies(:stan)
    creation_reason = 'backend'
    somebody.code_1 = creation_reason
    car = somebody.cars.new
    car.valid?
    assert_equal creation_reason, car.code_1
    assert_equal creation_reason, car.creation_reason
  end
end
