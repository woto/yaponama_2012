require 'test_helper'

class ModelTest < ActiveSupport::TestCase

  test 'Нельзя добавить модель бренду, не выпускающему автомобили' do
    brand = brands(:abs)
    model = Model.new(name: 'Model', brand: brand)
    refute model.valid?
    assert_equal ['Нельзя указать производителя, который не отмечен как выпускающий автомобили'], model.errors[:brand]
  end

  test 'Можно добавить модель бренду, выпускающему автомобили' do
    brand = brands(:acura)
    model = Model.new(name: 'Model', brand: brand)
    assert model.valid?
  end

end
