require 'test_helper'

class CarTest < ActiveSupport::TestCase

  test 'Мы можем создать новый автомобиль с брендом, отмеченным как is_brand' do
    car = Car.new(brand: brands(:toyota), model: models(:camry), vin_or_frame: 'frame')
    assert car.valid?
    refute car.errors[:brand].any?
  end

  # TODO В общем это так. Но пользователь создавая новый автомобиль по-умолчанию создает компанию не как is_brand
  # поэтому пока проверку на обязательность флага в модели закомментировал.
  #test 'Мы не можем создать новый автомобиль с брендом, НЕ отмеченным как is_brand' do
  #  car = Car.new(brand: brands(:mitsubishi), model: models(:galant), vin_or_frame: 'frame')
  #  refute car.valid?
  #  assert car.errors[:brand].any?
  #end
end
