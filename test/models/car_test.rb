require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test 'Если у пользователя выставлен code_1, и создается новый автомобиль, то он должен скопироваться на car. А также т.к. этот автомобиль новый, то должен выставиться creation_reason как и у user' do
    user = users(:stan)
    creation_reason = 'backend'
    user.code_1 = creation_reason
    car = user.cars.new
    car.valid?
    assert_equal creation_reason, car.code_1
    assert_equal creation_reason, car.creation_reason
  end
end
